package com.bestswlkh0310.graduating.graduatingserver.service.neis

import com.bestswlkh0310.graduating.graduatingserver.common.parse
import com.bestswlkh0310.graduating.graduatingserver.config.Properties
import com.bestswlkh0310.graduating.graduatingserver.entity.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.entity.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.mapper.toMealEntity
import com.bestswlkh0310.graduating.graduatingserver.repository.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.NeisRepository
import com.bestswlkh0310.graduating.graduatingserver.repository.SchoolRepository
import org.springframework.stereotype.Service
import java.time.LocalDateTime

@Service
class NeisMealService(
    private val neisRepository: NeisRepository,
    private val schoolRepository: SchoolRepository,
    private val properties: Properties,
    private val mealRepository: MealRepository
) {

    suspend fun getMeals(school: SchoolEntity): List<MealEntity> {
        val currentDate = LocalDateTime.now()
        val nextDate = currentDate.plusDays(6) // A week
        val response = neisRepository.getMeals(
            key = properties.neisApiKey,
            code = school.officeCode,
            schoolCode = school.code,
            fromDate = currentDate.parse("yyyyMMdd"),
            toDate = nextDate.parse("yyyyMMdd")
        )

        val result = arrayListOf<MealEntity>()

        response?.mealServiceDietInfo?.let { res ->
            res.mapNotNull { it?.row }
                .forEach { rows ->
                    for (meal in rows) {
                        try {
                            if (meal == null) continue
                            val entity = meal.toMealEntity(school = school)
                            if (entity == null) {
                                println(meal)
                                continue
                            }
                            result.add(entity)
                        } catch (e: Exception) {
                            e.printStackTrace()
                        }
                    }
                }
        }

        return result
    }

//    suspend fun saveMeals() {
//        val meals = schoolRepository.findAll().flatMapIndexed { idx, school ->
//            val meals = getMeals(school)
//            println("[$idx] school.id - ${school.id} , size - ${meals.size}")
//            return@flatMapIndexed meals
//        }
//        println(meals.size)
//        mealRepository.saveAll(meals)
//    }
}