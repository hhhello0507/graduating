package com.bestswlkh0310.graduating.graduatingserver.config

import com.bestswlkh0310.graduating.graduatingserver.repository.NeisRepository
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

@Configuration
class RetrofitConfig {

    val retrofit: Retrofit by lazy {
        Retrofit.Builder()
            .baseUrl("https://open.neis.go.kr/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    @Bean
    fun neisRepository() = retrofit.create(NeisRepository::class.java)
}