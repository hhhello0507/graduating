package com.bestswlkh0310.graduating.graduatingserver

import com.bestswlkh0310.graduating.graduatingserver.service.SchoolService
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
    val schoolService: SchoolService
) : CommandLineRunner {
    override fun run(vararg args: String?) {
        schoolService.importCsv("/Users/hhhello0507/Downloads/school.csv")
    }
}
