package com.bestswlkh0310.graduating.graduatingserver.api.meal

import org.springframework.web.bind.annotation.*


@RestController
@RequestMapping("/meals")
class MealController(
    private val mealService: MealService
) {
    @GetMapping("/{schoolId}", "/{schoolId}/")
    fun getMeals(@PathVariable("schoolId") schoolId: Long) = 
        mealService.getMeals(schoolId)
}