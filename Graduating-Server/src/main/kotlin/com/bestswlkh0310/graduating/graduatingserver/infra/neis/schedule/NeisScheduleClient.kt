package com.bestswlkh0310.graduating.graduatingserver.infra.neis.schedule

import com.bestswlkh0310.graduating.graduatingserver.core.graduating.GraduatingEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.core.graduating.GraduatingRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import com.bestswlkh0310.graduating.graduatingserver.infra.neis.NeisProperties
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import mu.KLogger
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Component
import org.springframework.web.client.RestClient
import org.springframework.web.client.body

@Component
class NeisScheduleClient(
    @Qualifier("neis")
    private val restClient: RestClient,
    private val neisProperties: NeisProperties,
    private val logger: KLogger
) {

    suspend fun getSchoolGraduatingDays(school: SchoolEntity): List<GraduatingEntity> {
        val response = restClient.get()
            .uri { uriBuilder ->
                uriBuilder
                    .path("hub/SchoolSchedule")
                    .queryParam("KEY", neisProperties.apiKey)
                    .queryParam("Type", "json")
                    .queryParam("ATPT_OFCDC_SC_CODE", school.officeCode)
                    .queryParam("SD_SCHUL_CODE", school.code)
                    .queryParam("AA_FROM_YMD", "20241201")
                    .queryParam("AA_TO_YMD", "20250301")
                    .build()
            }
            .retrieve()
            .body<String>()
            .let { it ?: throw CustomException(HttpStatus.INTERNAL_SERVER_ERROR, "Neis Error") }
            .let { jacksonObjectMapper().readValue(it, NeisSchedulesRes::class.java) }

        val result = response.schoolSchedule
            .mapNotNull { it.row }
            .flatten()
            .filter { it.eventNm.contains("졸업") }
            .map { GraduatingEntity(school = school, graduatingDay = it.aaYmd) }

        if (result.isEmpty()) {
            logger.info("❌ - ${school.name} - 알 수 없음 ${response.schoolSchedule}")
        } else {
            result.forEach {
                logger.info("✅ - ${school.name}: ${it.graduatingDay}")
            }
        }
        return result
    }
}