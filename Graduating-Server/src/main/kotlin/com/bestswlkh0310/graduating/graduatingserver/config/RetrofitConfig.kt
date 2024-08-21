package com.bestswlkh0310.graduating.graduatingserver.config

import com.bestswlkh0310.graduating.graduatingserver.dto.SchoolSchedulesResponse
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.Query

@Configuration
class RetrofitConfig {

    private val BASE_URL = "https://open.neis.go.kr/"

    val retrofit: Retrofit by lazy {
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }

    @Bean
    fun apiService() = retrofit.create(NeisApi::class.java)
}

interface NeisApi {
    @GET("hub/SchoolSchedule")
    suspend fun getSchoolSchedule(
        @Query("KEY") key: String,
        @Query("Type") type: String,
        @Query("ATPT_OFCDC_SC_CODE") code: String,
        @Query("SD_SCHUL_CODE") schoolCode: String,
        @Query("AA_FROM_YMD") fromDate: String,
        @Query("AA_TO_YMD") toDate: String
    ): SchoolSchedulesResponse?
}