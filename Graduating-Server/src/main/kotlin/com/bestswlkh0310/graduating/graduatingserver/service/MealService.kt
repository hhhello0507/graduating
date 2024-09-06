package com.bestswlkh0310.graduating.graduatingserver.service

import com.bestswlkh0310.graduating.graduatingserver.dto.MealRes
import com.bestswlkh0310.graduating.graduatingserver.repository.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.getBy
import com.bestswlkh0310.graduating.graduatingserver.service.neis.NeisMealService
import kotlinx.coroutines.runBlocking
import org.springframework.stereotype.Service
import java.time.LocalDate

@Service
class MealService(
    private val mealRepository: MealRepository,
    private val schoolRepository: SchoolRepository,
    private val neisMealService: NeisMealService
) {

    fun getMeals(schoolId: Long): List<MealRes> {
        val school = schoolRepository.getBy(schoolId)

        val currentTime = LocalDate.now()
        val schools = mealRepository.findBySchoolIdAndMealDate(schoolId, currentTime)
        val included = schools.any {
            it.mealDate == currentTime && it.school.id == schoolId
        }
        if (included) {
            return schools.map { MealRes.of(it) }
        }
        return runBlocking {
            val meals = neisMealService.getMeals(
                school = school,
            )
            mealRepository.saveAll(meals)
                .map { MealRes.of(it) }
        }
    }

    fun deleteMealAll() {
        mealRepository.deleteAll()
    }
}