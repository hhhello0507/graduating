package com.bestswlkh0310.graduating.graduatingserver.api.meal

import com.bestswlkh0310.graduating.graduatingserver.api.meal.req.GetMealsReq
import com.bestswlkh0310.graduating.graduatingserver.api.meal.res.MealRes
import com.bestswlkh0310.graduating.graduatingserver.core.global.safeSaveAll
import com.bestswlkh0310.graduating.graduatingserver.core.meal.MealRepository
import com.bestswlkh0310.graduating.graduatingserver.core.user.UserAuthenticationHolder
import com.bestswlkh0310.graduating.graduatingserver.global.exception.CustomException
import com.bestswlkh0310.graduating.graduatingserver.infra.neis.meal.NeisMealClient
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service

@Service
class MealServiceImpl(
    private val mealRepository: MealRepository,
    private val neisMealClient: NeisMealClient,
    private val authenticationHolder: UserAuthenticationHolder
): MealService {
    override fun getMeals(req: GetMealsReq): List<MealRes> {
        val school = authenticationHolder.current().school ?: throw CustomException(HttpStatus.NOT_FOUND, "Not found school")

        val time = req.toLocalDate()
        val schools = mealRepository.findBySchoolIdAndMealDate(school.id, time)
        if (schools.isNotEmpty()) {
            return schools.map { MealRes.of(it) }
        }
        
        val meals = neisMealClient.getMeals(
            school = school,
            fromDate = time,
        )
        mealRepository.safeSaveAll(meals)

        return mealRepository.findBySchoolIdAndMealDate(school.id, time)
            .map { MealRes.of(it) }
    }

    override fun deleteMealAll() {
        mealRepository.deleteOldRecords()
    }
}