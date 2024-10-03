package com.bestswlkh0310.graduating.graduatingserver.service

import com.bestswlkh0310.graduating.graduatingserver.dto.MealRes
import com.bestswlkh0310.graduating.graduatingserver.entity.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.repository.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.SchoolRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.getBy
import com.bestswlkh0310.graduating.graduatingserver.service.neis.NeisMealService
import jakarta.persistence.PersistenceException
import kotlinx.coroutines.runBlocking
import mu.KLogger
import org.springframework.stereotype.Service
import java.sql.SQLException
import java.time.LocalDate

@Service
class MealService(
    private val mealRepository: MealRepository,
    private val schoolRepository: SchoolRepository,
    private val neisMealService: NeisMealService,
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