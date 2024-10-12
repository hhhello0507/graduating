package com.bestswlkh0310.graduating.graduatingserver.global.loader

import com.bestswlkh0310.graduating.graduatingserver.core.scholarship.ScholarshipRepository
import com.bestswlkh0310.graduating.graduatingserver.infra.publicdata.kosaf.KosafClient
import org.springframework.boot.CommandLineRunner
import org.springframework.stereotype.Component
import java.time.LocalDate

//@Component
class KosafScholarshipLoader(
    private val kasafClient: KosafClient,
    private val scholarshipRepository: ScholarshipRepository
) : CommandLineRunner {
    override fun run(vararg args: String?) {
        val currentTime = LocalDate.now()
        kasafClient.fetchScholarships("2cf1dfc1-f860-4a22-9ddb-bb523935801f")
            .filter {
                it.recruitmentEndDate == null
                        || it.recruitmentEndDate!!.isAfter(currentTime)
                        || it.recruitmentEndDate!!.isEqual(currentTime)
            }
            .let {
                scholarshipRepository.saveAll(it)
            }
    }
}