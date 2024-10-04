package com.bestswlkh0310.graduating.graduatingserver.core.meal

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.time.LocalDate

@Repository
interface MealRepository: JpaRepository<MealEntity, Long> {
    fun findBySchoolIdAndMealDate(schoolId: Long, mealDate: LocalDate): List<MealEntity>

    @Modifying
    @Query("DELETE FROM MealEntity e WHERE e.mealDate < CURRENT_DATE")
    fun deleteOldRecords()
}