package com.bestswlkh0310.graduating.graduatingserver.global.config

import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class PropertiesConfig(
    @Value("\${secret.neis.apikey}") val neisApiKey: String,
) {
    @Bean fun propertyConfig() = Properties(
        neisApiKey = neisApiKey
    )
}