package com.bestswlkh0310.graduating.graduatingserver.infra.neis.school

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolType
import mu.KLogger
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.stereotype.Component
import java.io.File
import java.nio.charset.StandardCharsets
import java.time.LocalDate
import java.time.format.DateTimeFormatter

@Component
class NeisSchoolClient(
    private val logger: KLogger,
) {
    fun importCsv(filePath: String): List<SchoolEntity> {
        val file = File(filePath)
        val parser = CSVParser.parse(file, StandardCharsets.UTF_8, CSVFormat.DEFAULT.withFirstRecordAsHeader())

        val ret = parser.mapNotNull { record ->
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
                logger.error("Neis Error", e)
                null
            }
        }

        parser.close()
        
        return ret
    }
}