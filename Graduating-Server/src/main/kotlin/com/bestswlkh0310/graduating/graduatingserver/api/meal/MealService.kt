package com.bestswlkh0310.graduating.graduatingserver.api.meal

import com.bestswlkh0310.graduating.graduatingserver.api.meal.res.MealRes
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.getBy
import com.bestswlkh0310.graduating.graduatingserver.infra.neis.NeisMealHelper
import jakarta.persistence.PersistenceException
import kotlinx.coroutines.runBlocking
import mu.KLogger
import org.springframework.stereotype.Service
import java.time.LocalDate

@Service
class MealService(
    private val mealRepository: MealRepository,
    private val schoolRepository: SchoolRepository,
    private val neisMealService: NeisMealHelper,
    private val logger: KLogger,
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
        // This code is really suck.
        return runBlocking {
            val result = arrayListOf<MealEntity>()
            neisMealService.getMeals(
                school = school,
            ).forEach {
                try {
                    result.add(
                        mealRepository.save(it)
                    )
                } catch (e: PersistenceException) {
                    logger.error("duplicate mealEntity.")
                }
            }
            return@runBlocking result
                .filter { it.mealDate == currentTime }
                .map { MealRes.of(it) }
        }
    }

    fun deleteMealAll() {
        mealRepository.deleteAll()
    }
}