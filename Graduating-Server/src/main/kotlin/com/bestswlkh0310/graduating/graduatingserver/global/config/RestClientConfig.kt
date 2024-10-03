package com.bestswlkh0310.graduating.graduatingserver.global.config

import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.client.RestClient

@Configuration
class RestClientConfig {
    @Bean
    @Qualifier("neis")
    fun restClient() = RestClient.builder()
        .baseUrl("https://open.neis.go.kr")
        .build()
}