package com.bestswlkh0310.graduating.graduatingserver

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.ConfigurationPropertiesScan
import org.springframework.boot.runApplication
import org.springframework.scheduling.annotation.EnableScheduling

@SpringBootApplication
@EnableScheduling
@ConfigurationPropertiesScan
class GraduatingServerApplication

fun main(args: Array<String>) {
    runApplication<GraduatingServerApplication>(*args)
}