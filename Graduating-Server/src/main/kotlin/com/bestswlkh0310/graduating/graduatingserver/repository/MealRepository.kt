package com.bestswlkh0310.graduating.graduatingserver.repository

import com.bestswlkh0310.graduating.graduatingserver.entity.MealEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.time.LocalDate

@Repository
interface MealRepository: JpaRepository<MealEntity, Long> {
    fun findBySchoolIdAndMealDate(schoolId: Long, mealDate: LocalDate): List<MealEntity>
}