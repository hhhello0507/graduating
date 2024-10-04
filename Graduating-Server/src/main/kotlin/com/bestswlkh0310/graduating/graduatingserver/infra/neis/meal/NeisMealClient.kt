package com.bestswlkh0310.graduating.graduatingserver.infra.neis.meal

import java.time.LocalDateTime
import com.bestswlkh0310.graduating.graduatingserver.common.parse
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import com.bestswlkh0310.graduating.graduatingserver.infra.neis.NeisProperties
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.stereotype.Component
import org.springframework.web.client.RestClient
import org.springframework.web.client.body
import mu.KLogger
import org.springframework.http.HttpStatus

@Component
class NeisMealClient(
    private val neisProperties: NeisProperties,
    @Qualifier("neis")
    private val restClient: RestClient,
    private val logger: KLogger,
) {
    fun getMeals(school: SchoolEntity): List<MealEntity> {
        val currentDate = LocalDateTime.now()
        val nextDate = currentDate.plusDays(6) // A week
        return restClient.get()
            .uri { uriBuilder ->
                uriBuilder
                    .path("hub/mealServiceDietInfo")
                    .queryParam("KEY", neisProperties.apiKey)
                    .queryParam("Type", "json")
                    .queryParam("ATPT_OFCDC_SC_CODE", school.officeCode)
                    .queryParam("SD_SCHUL_CODE", school.code)
                    .queryParam("MLSV_FROM_YMD", currentDate.parse("yyyyMMdd"))
                    .queryParam("MLSV_TO_YMD", nextDate.parse("yyyyMMdd"))
                    .build()
            }
            .retrieve()
            .body<String>()
            .let { it ?: throw CustomException(HttpStatus.INTERNAL_SERVER_ERROR, "Neis Error") }
            .let { jacksonObjectMapper().readValue<NeisMealsRes>(it) }
            .mealServiceDietInfo
            .mapNotNull { it?.row }
            .flatten()
            .mapNotNull { meal ->
                try {
                    meal.toEntity(school = school)
                } catch (e: Exception) {
                    logger.error("Neis Error")
                    null
                }
            }
    }
}