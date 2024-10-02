//
//  MealViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation
import Model
import Data
import Combine

public final class MealViewModel: BaseViewModel {
    @Published var meals: [Meal]?
    @Published var mealsFetchFailure = false
    
    func fetchMeals(schoolId: Int) {
        MealService.shared.fetchMeals(
            schoolId: schoolId
        ).success { res in
            self.meals = res
        }.failure { error in
            self.meals = nil
            self.mealsFetchFailure = true
        }.observe(&subscriptions)
    }
}
