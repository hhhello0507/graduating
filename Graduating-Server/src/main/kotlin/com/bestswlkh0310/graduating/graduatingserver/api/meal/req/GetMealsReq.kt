package com.bestswlkh0310.graduating.graduatingserver.api.meal.req

import jakarta.validation.constraints.Max
import jakarta.validation.constraints.Min
import java.time.LocalDate

data class GetMealsReq(
    @Min(1900) @Max(2100)
    val year: Int,
    @Min(1) @Max(12)
    val month: Int,
    @Min(1) @Max(31)
    val day: Int
) {
    fun toLocalDate(): LocalDate = LocalDate.of(year, month, day)
    
    companion object {
        fun current(): GetMealsReq {
            val now = LocalDate.now()
            return GetMealsReq(
                year = now.year,
                month = now.monthValue,
                day = now.dayOfMonth
            )
        }
    }
}