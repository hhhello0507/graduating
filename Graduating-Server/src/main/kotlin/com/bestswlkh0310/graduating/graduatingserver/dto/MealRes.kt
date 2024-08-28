package com.bestswlkh0310.graduating.graduatingserver.dto

import com.bestswlkh0310.graduating.graduatingserver.entity.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.MealType
import java.time.LocalDate

data class MealRes(
    val id: Long = 0,
    val mealType: MealType?,
    val calorie: Double,
    val menu: String,
    val mealInfo: String,
    val mealDate: LocalDate,
    val schoolId: Long
) {
    companion object {
        fun of(mealEntity: MealEntity) = MealRes(
            id = mealEntity.id,
            mealType = mealEntity.mealType,
            calorie = mealEntity.calorie,
            menu = mealEntity.menu,
            mealInfo = mealEntity.mealInfo,
            mealDate = mealEntity.mealDate,
            schoolId = mealEntity.school.id
        )
    }
}
