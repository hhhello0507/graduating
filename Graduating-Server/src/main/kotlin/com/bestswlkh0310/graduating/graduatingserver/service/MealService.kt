package com.bestswlkh0310.graduating.graduatingserver.service

import com.bestswlkh0310.graduating.graduatingserver.repository.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.service.neis.NeisMealService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service

@Service
class MealService(
    private val mealRepository: MealRepository,
    private val neisMealService: NeisMealService
) {
    fun handleMeals() {
        mealRepository.deleteAll()
        runBlocking {
            neisMealService.saveMeals()
        }
    }
}