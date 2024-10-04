package com.bestswlkh0310.graduating.graduatingserver.global.config

import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.converter.json.GsonHttpMessageConverter
import org.springframework.web.client.RestClient

@Configuration
class RestClientConfig {
    @Bean
    @Qualifier("neis")
    fun neisRestClient() = RestClient.builder()
        .baseUrl("https://open.neis.go.kr")
        .build()

    @Bean
    @Qualifier("google")
    fun googleOAuth2RestClient() = RestClient.builder()
        .baseUrl("https://oauth2.googleapis.com")
        .build()

    @Bean
    @Qualifier("apple")
    fun appleOAuth2RestClient() = RestClient.builder()
        .baseUrl("https://appleid.apple.com")
        .build()
}