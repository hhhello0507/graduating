package com.bestswlkh0310.graduating.graduatingserver.controller

import com.bestswlkh0310.graduating.graduatingserver.service.MealService
import org.springframework.web.bind.annotation.*


@RestController
@RequestMapping("/meals")
class MealController(
    private val mealService: MealService
) {
    @GetMapping("/{schoolId}", "/{schoolId}/")
    fun getMeals(@PathVariable("schoolId") schoolId: Long, ) = mealService.getMeals(schoolId)
}