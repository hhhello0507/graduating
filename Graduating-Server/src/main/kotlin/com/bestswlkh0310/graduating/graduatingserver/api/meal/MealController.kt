package com.bestswlkh0310.graduating.graduatingserver.api.meal

import org.springframework.web.bind.annotation.*


@RestController
@RequestMapping("/meals")
class MealController(
    private val mealService: MealService
) {
    @GetMapping
    fun getMeals() = mealService.getMeals()
}