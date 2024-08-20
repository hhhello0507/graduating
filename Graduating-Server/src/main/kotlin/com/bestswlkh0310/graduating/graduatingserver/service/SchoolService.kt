package com.bestswlkh0310.graduating.graduatingserver.service

import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolType
import com.bestswlkh0310.graduating.graduatingserver.repository.SchoolRepository
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.apache.commons.csv.CSVRecord
import org.springframework.stereotype.Service
import java.io.File
import java.nio.charset.StandardCharsets

@Service
class SchoolService(
    private val schoolRepository: SchoolRepository
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
                anniversary = v[9]
            )
            schoolRepository.save(school)
        }

        parser.close()
    }

    fun getSchools(): List<SchoolEntity> {
        return schoolRepository.findAll()
    }
}