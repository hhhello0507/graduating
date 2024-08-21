package com.bestswlkh0310.graduating.graduatingserver.service

import com.bestswlkh0310.graduating.graduatingserver.config.NeisApi
import com.bestswlkh0310.graduating.graduatingserver.entity.GraduatingEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolType
import com.bestswlkh0310.graduating.graduatingserver.repository.GraduatingRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.SchoolRepository
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import java.io.File
import java.nio.charset.StandardCharsets

@Service
class NeisService(
    private val schoolRepository: SchoolRepository,
    private val graduatingRepository: GraduatingRepository,
    private val neisApi: NeisApi,
    @Value("\${secret.neis.apikey}") private val apiKey: String
) {

    private fun getSchoolType(str: String): SchoolType? {
        return when (str) {
            "초등학교" -> SchoolType.ELEMENTARY
            "중학교" -> SchoolType.MIDDLE
            "고등학교" -> SchoolType.HIGH
            else -> null
        }
    }

    fun importCsv(filePath: String) {
        val file = File(filePath)
        val parser = CSVParser.parse(file, StandardCharsets.UTF_8, CSVFormat.DEFAULT.withFirstRecordAsHeader())

        for (record in parser) {
            val v = record.toList()
            val school = SchoolEntity(
                name = v[0],
                type = getSchoolType(v[1]),
                cityName = v[2],
                postalCode = v[3],
                address = v[4],
                addressDetail = v[5],
                phone = v[6],
                website = v[7],
                createdAt = v[8],
                anniversary = v[9],
                code = v[10],
                officeCode = v[11]
            )
            schoolRepository.save(school)
        }

        parser.close()
    }

    suspend fun getSchoolDate(school: SchoolEntity) {
        try {
            val response = neisApi.getSchoolSchedule(
                key = apiKey,
                type = "json",
                code = school.officeCode,
                schoolCode = school.code,
                fromDate = "20241201",
                toDate = "20250301"
            )
            var includeGraduating = false
            response?.schoolSchedule?.let { res ->
                res
                    .mapNotNull { it?.row }
                    .forEach { rows ->
                        rows.forEach { row ->
                            if (row.eventNm.contains("졸업")) {
                                println("✅ - ${school.name} - ${row.eventNm}")
                                includeGraduating = true
                                val entity = GraduatingEntity(
                                    schoolId = school.id,
                                    graduatingDay = row.aaYmd,
                                )
                                graduatingRepository.save(entity)
                            }
                        }
                    }
            }

            if (!includeGraduating) {
                println("❌ - ${school.name} - 알 수 없음 ${response?.schoolSchedule}")
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
//        val headers = HttpHeaders().apply {
//            set("Accept", "*/*")
//            set("User-Agent", "PostmanRuntime/7.41.1")
//        }
    }

    suspend fun getSchoolsDate() {
        val schools = schoolRepository.findAll()
        schools.forEach {
            getSchoolDate(it)
        }
    }
}