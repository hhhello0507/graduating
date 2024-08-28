package com.bestswlkh0310.graduating.graduatingserver

import com.bestswlkh0310.graduating.graduatingserver.service.neis.NeisScheduleService
import kotlinx.coroutines.runBlocking
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.scheduling.annotation.EnableScheduling

@SpringBootApplication
@EnableScheduling
class GraduatingServerApplication

fun main(args: Array<String>) {
    runApplication<GraduatingServerApplication>(*args)
}
