package com.bestswlkh0310.graduating.graduatingserver.service.neis

import com.bestswlkh0310.graduating.graduatingserver.config.Properties
import com.bestswlkh0310.graduating.graduatingserver.entity.GraduatingEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolType
import com.bestswlkh0310.graduating.graduatingserver.repository.GraduatingRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.NeisRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.SchoolRepository
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service
import java.io.File
import java.nio.charset.StandardCharsets
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

// TODO: 코드 개선 (함수)
// 다음 연도가 되면 개선할 듯.......
@Service
class NeisScheduleService(
    private val schoolRepository: SchoolRepository,
    private val graduatingRepository: GraduatingRepository,
    private val neisApi: NeisRepository,
    private val properties: Properties
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
            val response = neisApi.getSchoolSchedule(
                key = properties.neisApiKey,
                code = school.officeCode,
                schoolCode = school.code,
                fromDate = "20241201",
                toDate = "20250301"
            )
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