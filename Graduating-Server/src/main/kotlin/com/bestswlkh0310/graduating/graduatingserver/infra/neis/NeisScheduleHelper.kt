package com.bestswlkh0310.graduating.graduatingserver.infra.neis

import com.bestswlkh0310.graduating.graduatingserver.core.graduating.GraduatingEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolType
import com.bestswlkh0310.graduating.graduatingserver.core.graduating.GraduatingRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.stereotype.Component
import org.springframework.web.client.RestClient
import java.io.File
import java.nio.charset.StandardCharsets
import java.time.LocalDate
import java.time.format.DateTimeFormatter

// TODO: 코드 개선 (함수)
// 다음 연도가 되면 개선할 듯.......
@Component
class NeisScheduleHelper(
    private val schoolRepository: SchoolRepository,
    private val graduatingRepository: GraduatingRepository,
    @Qualifier("neis")
    private val restClient: RestClient,
    private val neisProperties: NeisProperties
) {

    fun importCsv(filePath: String) {
        val file = File(filePath)
        val parser = CSVParser.parse(file, StandardCharsets.UTF_8, CSVFormat.DEFAULT.withFirstRecordAsHeader())

        parser.mapNotNull { record ->
            val v = record.toList()
            try {
                SchoolEntity(
                    officeCode = v[0],
                    code = v[1],
                    name = v[2],
                    type = SchoolType.ofKorean(v[3]),
                    cityName = v[4],
                    postalCode = v[5],
                    address = v[6],
                    addressDetail = v[7],
                    phone = v[8],
                    website = v[9],
                    createdAt = LocalDate.parse(v[10], DateTimeFormatter.ofPattern("yyyyMMdd")),
                    anniversary = LocalDate.parse(v[11], DateTimeFormatter.ofPattern("yyyyMMdd")),
                )
            } catch (e: Exception) {
                e.printStackTrace()
                null
            }
        }.let {
            schoolRepository.saveAll(it)
        }

        parser.close()
    }

    private suspend fun getSchoolDate(school: SchoolEntity): List<GraduatingEntity> {
        val result = arrayListOf<GraduatingEntity>()
        try {
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
                .toEntity(NeisSchedulesRes::class.java)
                .body

            var includeGraduating = false
            response?.SchoolSchedule?.let { res ->
                res.mapNotNull { it?.row }
                    .forEach { rows ->
                        rows.forEach { row ->
                            if (row.EVENT_NM.contains("졸업")) {
                                println("✅ - ${school.name} - ${row.EVENT_NM}")
                                includeGraduating = true
                                val entity = GraduatingEntity(
                                    schoolId = school.id,
                                    graduatingDay = row.AA_YMD,
                                )
                                result.add(entity)
                            }
                        }
                    }
            }

            if (!includeGraduating) {
                println("❌ - ${school.name} - 알 수 없음 ${response?.SchoolSchedule}")
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return result
    }

    suspend fun getSchoolsDate() {
        val schools = schoolRepository.findAll()
        schools.map {
            getSchoolDate(it)
        }.flatMap {
            graduatingRepository.saveAll(it)
        }
    }
}