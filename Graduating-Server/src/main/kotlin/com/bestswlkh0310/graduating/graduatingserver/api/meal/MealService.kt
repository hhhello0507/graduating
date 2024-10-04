package com.bestswlkh0310.graduating.graduatingserver.api.meal

import com.bestswlkh0310.graduating.graduatingserver.api.meal.res.MealRes
import com.bestswlkh0310.graduating.graduatingserver.core.global.safeSaveAll
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.getBy
import com.bestswlkh0310.graduating.graduatingserver.infra.neis.meal.NeisMealClient
import org.springframework.stereotype.Service
import java.time.LocalDate

@Service
class MealService(
    private val mealRepository: MealRepository,
    private val schoolRepository: SchoolRepository,
    private val neisMealClient: NeisMealClient,
) {

    fun getMeals(schoolId: Long): List<MealRes> {
        val school = schoolRepository.getBy(schoolId)

        val currentTime = LocalDate.now()
        val schools = mealRepository.findBySchoolIdAndMealDate(schoolId, currentTime)
        if (schools.isNotEmpty()) {
            return schools.map { MealRes.of(it) }
        }
        
        val meals = neisMealClient.getMeals(school = school)
        mealRepository.safeSaveAll(meals)

        return mealRepository.findBySchoolIdAndMealDate(schoolId, currentTime)
            .map { MealRes.of(it) }
    }

    fun deleteMealAll() {
        mealRepository.deleteOldRecords()
    }
}