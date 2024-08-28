package com.bestswlkh0310.graduating.graduatingserver

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.scheduling.annotation.EnableScheduling

@SpringBootApplication
@EnableScheduling
class GraduatingServerApplication

fun main(args: Array<String>) {
    runApplication<GraduatingServerApplication>(*args)
}
