package com.bestswlkh0310.graduating.graduatingserver.scheduler

import com.bestswlkh0310.graduating.graduatingserver.service.MealService
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component

@Component
class MealScheduler(
    private val mealService: MealService
) {

    @Scheduled(cron = "0 0 23 * * *", zone = "Asia/Seoul")
    fun scheduleMeals() {
        mealService.handleMeals()
    }
}