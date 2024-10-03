package com.bestswlkh0310.graduating.graduatingserver.infra.neis

import com.bestswlkh0310.graduating.graduatingserver.common.toLocalDate
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealType
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity

fun NeisMealRowRes.toMealEntity(school: SchoolEntity): MealEntity? {
    val time = this.MLSV_TO_YMD.toLocalDate("yyyyMMdd") ?: return null
    return MealEntity(
        mealType = MealType.ofKorean(this.MMEAL_SC_NM),
        menu = this.DDISH_NM,
        calorie = this.CAL_INFO.substringBefore(" Kcal").toDoubleOrNull() ?: 0.0,
        mealInfo = this.ORPLC_INFO,
        mealDate = time,
        school = school
    )
}