package com.bestswlkh0310.graduating.graduatingserver.api.meal.res

import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealType
import java.time.LocalDate

data class MealRes(
    val id: Long = 0,
    val mealType: MealType?,
    val calorie: Double,
    val menu: List<String>,
    val mealInfo: List<String>,
    val mealDate: LocalDate,
    val schoolId: Long
) {
    companion object {
        fun of(mealEntity: MealEntity) = MealRes(
            id = mealEntity.id,
            mealType = mealEntity.mealType,
            calorie = mealEntity.calorie,
            menu = mealEntity.menu.split("<br/>"),
            mealInfo = mealEntity.mealInfo.split("<br/>"),
            mealDate = mealEntity.mealDate,
            schoolId = mealEntity.school.id
        )
    }
}
