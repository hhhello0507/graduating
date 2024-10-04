package com.bestswlkh0310.graduating.graduatingserver.infra.neis

import com.bestswlkh0310.graduating.graduatingserver.common.parse
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealEntity
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolEntity
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.core.school.SchoolRepository
import mu.KLogger
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.stereotype.Component
import org.springframework.web.client.RestClient
import java.time.LocalDateTime

@Component
class NeisMealHelper(
    private val schoolRepository: SchoolRepository,
    private val neisProperties: NeisProperties,
    private val mealRepository: MealRepository,
    @Qualifier("neis")
    private val restClient: RestClient,
    private val logger: KLogger,
) {

    suspend fun getMeals(school: SchoolEntity): List<MealEntity> {
        val currentDate = LocalDateTime.now()
        val nextDate = currentDate.plusDays(6) // A week

        val response = restClient.get()
            .uri { uriBuilder ->
                uriBuilder
                    .path("hub/mealServiceDietInfo")
                    .queryParam("KEY", neisProperties.apiKey)
                    .queryParam("Type", "json")
                    .queryParam("ATPT_OFCDC_SC_CODE", school.officeCode)
                    .queryParam("SD_SCHUL_CODE", school.code)
                    .queryParam("MLSV_FROM_YMD", currentDate.parse("yyyyMMdd"))
                    .queryParam("MLSV_TO_YMD", nextDate.parse("yyyyMMdd"))
                    .build()
            }
            .retrieve()
            .toEntity(NeisMealsRes::class.java)
            .body

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
                            logger.error("Neis Error")
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