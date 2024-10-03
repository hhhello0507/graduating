package com.bestswlkh0310.graduating.graduatingserver.infra.neis

import retrofit2.http.GET
import retrofit2.http.Query

interface NeisApi {
    @GET("hub/SchoolSchedule")
    suspend fun getSchoolSchedule(
        @Query("KEY") key: String,
        @Query("Type") type: String = "json",
        @Query("ATPT_OFCDC_SC_CODE") code: String,
        @Query("SD_SCHUL_CODE") schoolCode: String,
        @Query("AA_FROM_YMD") fromDate: String,
        @Query("AA_TO_YMD") toDate: String
    ): NeisSchedulesRes?

    @GET("hub/mealServiceDietInfo")
    suspend fun getMeals(
        @Query("KEY") key: String,
        @Query("Type") type: String = "json",
        @Query("ATPT_OFCDC_SC_CODE") code: String,
        @Query("SD_SCHUL_CODE") schoolCode: String,
        @Query("MLSV_FROM_YMD") fromDate: String,
        @Query("MLSV_TO_YMD") toDate: String
    ): NeisMealsRes?
}