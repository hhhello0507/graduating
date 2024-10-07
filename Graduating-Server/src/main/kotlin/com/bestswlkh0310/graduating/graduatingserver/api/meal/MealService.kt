package com.bestswlkh0310.graduating.graduatingserver.api.meal

import com.bestswlkh0310.graduating.graduatingserver.api.meal.res.MealRes
import com.bestswlkh0310.graduating.graduatingserver.core.global.safeSaveAll
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserAuthenticationHolder
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import com.bestswlkh0310.graduating.graduatingserver.infra.neis.meal.NeisMealClient
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import java.time.LocalDate

@Service
class MealService(
    private val mealRepository: MealRepository,
    private val neisMealClient: NeisMealClient,
    private val authenticationHolder: UserAuthenticationHolder
) {
    fun getMeals(): List<MealRes> {
        val school = authenticationHolder.current().school ?: throw CustomException(HttpStatus.NOT_FOUND, "Not found school")

        val currentTime = LocalDate.now()
        val schools = mealRepository.findBySchoolIdAndMealDate(school.id, currentTime)
        if (schools.isNotEmpty()) {
            return schools.map { MealRes.of(it) }
        }
        
        val meals = neisMealClient.getMeals(school = school)
        mealRepository.safeSaveAll(meals)

        return mealRepository.findBySchoolIdAndMealDate(school.id, currentTime)
            .map { MealRes.of(it) }
    }

    fun deleteMealAll() {
        mealRepository.deleteOldRecords()
    }
}