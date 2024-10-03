package com.bestswlkh0310.graduating.graduatingserver.config

import mu.KotlinLogging
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class LogConfig {
    @Bean
    fun logger() = KotlinLogging.logger { }
}