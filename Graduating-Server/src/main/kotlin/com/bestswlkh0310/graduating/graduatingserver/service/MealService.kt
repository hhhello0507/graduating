package com.bestswlkh0310.graduating.graduatingserver.service

import com.bestswlkh0310.graduating.graduatingserver.common.parse
import com.bestswlkh0310.graduating.graduatingserver.entity.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.repository.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.service.neis.NeisMealService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import org.springframework.data.repository.findByIdOrNull
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service
import java.time.LocalDate
import java.time.LocalDateTime

@Service
class MealService(
    private val mealRepository: MealRepository,
    private val schoolRepository: SchoolRepository,
    private val neisMealService: NeisMealService
) {
//    fun handleMeals() {
//        mealRepository.deleteAll()
//        runBlocking {
//            neisMealService.saveMeals()
//        }
//    }

    fun getMeals(schoolId: Long): List<MealEntity> {
        val school = schoolRepository.findByIdOrNull(schoolId) ?: throw Exception("No school with id $schoolId")

        val currentTime = LocalDate.now()
        val schools = mealRepository.findBySchoolIdAndMealDate(schoolId, currentTime)
        val included = schools.any {
            it.mealDate == currentTime && it.school.id == schoolId
        }
        if (included) {
            return schools
        }
        return runBlocking {
            val meals = neisMealService.getMeals(
                school = school,
            )
            mealRepository.saveAll(meals)
        }
    }
}