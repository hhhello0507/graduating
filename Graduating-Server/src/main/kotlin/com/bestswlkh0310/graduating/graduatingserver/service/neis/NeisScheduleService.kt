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

        for (record in parser) {
            val v = record.toList()
            val school = SchoolEntity(
                name = v[0],
                type = SchoolType.ofKorean(v[1]),
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
                                graduatingRepository.save(entity)
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
    }

    suspend fun getSchoolsDate() {
        val schools = schoolRepository.findAll()
        schools.forEach {
            getSchoolDate(it)
        }
    }
}