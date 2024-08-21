package com.bestswlkh0310.graduating.graduatingserver

import com.bestswlkh0310.graduating.graduatingserver.service.NeisService
import com.bestswlkh0310.graduating.graduatingserver.service.SchoolService
import kotlinx.coroutines.runBlocking
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.stereotype.Component

@SpringBootApplication
class GraduatingServerApplication

fun main(args: Array<String>) {
    runApplication<GraduatingServerApplication>(*args)
}

//@Component
class DataLoader(
    val neisService: NeisService
) : CommandLineRunner {
    override fun run(vararg args: String?) {
        neisService.importCsv("/Users/hhhello0507/Downloads/school.csv")
    }
}

@Component
class FetchSchool(
    val neisService: NeisService
) : CommandLineRunner {
    override fun run(vararg args: String?) {
        runBlocking {
            neisService.getSchoolsDate()
        }
    }
}