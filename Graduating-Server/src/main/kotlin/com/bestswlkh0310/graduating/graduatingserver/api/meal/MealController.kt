package com.bestswlkh0310.graduating.graduatingserver.api.meal

import com.bestswlkh0310.graduating.graduatingserver.api.meal.req.GetMealsReq
import jakarta.validation.Valid
import org.springframework.web.bind.annotation.*


@RestController
@RequestMapping("/meals")
class MealController(
    private val mealService: MealService
) {
    @GetMapping
    fun getMeals(@Valid @RequestBody req: GetMealsReq = GetMealsReq.current()) =
        mealService.getMeals(req)
}