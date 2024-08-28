package com.bestswlkh0310.graduating.graduatingserver.loader

import com.bestswlkh0310.graduating.graduatingserver.service.MealService
import org.springframework.boot.CommandLineRunner
import org.springframework.stereotype.Component

@Component
class MealLoader(
    private val mealService: MealService
) : CommandLineRunner {
    override fun run(vararg args: String?) {
        mealService.handleMeals()
    }
}