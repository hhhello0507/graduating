package com.bestswlkh0310.graduating.graduatingserver.global.loader

import com.bestswlkh0310.graduating.graduatingserver.infra.neis.NeisScheduleHelper
import kotlinx.coroutines.runBlocking
import org.springframework.boot.CommandLineRunner


//@Component
class DataLoader(
    private val neisService: NeisScheduleHelper
) : CommandLineRunner {
    override fun run(vararg args: String?) {
        neisService.importCsv("/Users/hhhello0507/Downloads/school.csv")
    }
}

//@Component
class FetchSchool(
    private val neisService: NeisScheduleHelper
) : CommandLineRunner {
    override fun run(vararg args: String?) {
        runBlocking {
            neisService.getSchoolsDate()
        }
    }
}