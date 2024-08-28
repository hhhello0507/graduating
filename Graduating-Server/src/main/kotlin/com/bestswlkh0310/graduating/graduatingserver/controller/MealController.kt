package com.bestswlkh0310.graduating.graduatingserver.controller

import com.bestswlkh0310.graduating.graduatingserver.service.MealService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/meal")
class MealController(
    private val mealService: MealService
) {
    @GetMapping("{schoolId}")
    fun getMeals(
        @PathVariable("schoolId") schoolId: Long
    ) = mealService.getMeals(schoolId = schoolId)
        .let { ResponseEntity.ok(it) }
}