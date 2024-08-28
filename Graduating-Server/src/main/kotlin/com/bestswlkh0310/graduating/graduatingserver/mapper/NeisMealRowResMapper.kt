package com.bestswlkh0310.graduating.graduatingserver.mapper

import com.bestswlkh0310.graduating.graduatingserver.common.kcal
import com.bestswlkh0310.graduating.graduatingserver.common.toTime
import com.bestswlkh0310.graduating.graduatingserver.dto.NeisMealRowRes
import com.bestswlkh0310.graduating.graduatingserver.entity.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.MealType
import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolEntity

fun NeisMealRowRes.toMealEntity(school: SchoolEntity): MealEntity? {
    val time = this.MLSV_TO_YMD.toTime("yyyyMMdd") ?: return null
    return MealEntity(
        mealType = MealType.ofKorean(this.MMEAL_SC_NM),
        menu = this.DDISH_NM,
        calorie = this.CAL_INFO.kcal() ?: 0.0,
        mealInfo = this.ORPLC_INFO,
        mealDate = time,
        school = school
    )
}