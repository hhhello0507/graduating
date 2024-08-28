package com.bestswlkh0310.graduating.graduatingserver.repository

import com.bestswlkh0310.graduating.graduatingserver.dto.SchoolSchedulesResponse
import retrofit2.http.GET
import retrofit2.http.Query

interface NeisRepository {
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