package com.bestswlkh0310.graduating.graduatingserver.global.loader

import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.infra.neis.school.NeisSchoolClient
import org.springframework.boot.CommandLineRunner


//@Component
class FetchSchoolRunner(
    private val neisSchoolClient: NeisSchoolClient,
    private val schoolRepository: SchoolRepository
) : CommandLineRunner {
    override fun run(vararg args: String?) {
        val schools = neisSchoolClient.importCsv("/Users/hhhello0507/Downloads/school.csv")
        schoolRepository.saveAll(schools)
    }
}