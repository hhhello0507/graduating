package com.bestswlkh0310.graduating.graduatingserver.api.meal

import com.bestswlkh0310.graduating.graduatingserver.api.meal.req.GetMealsReq
import com.bestswlkh0310.graduating.graduatingserver.api.meal.res.MealRes

interface MealService {
    fun getMeals(req: GetMealsReq): List<MealRes>
    fun deleteMealAll()
}