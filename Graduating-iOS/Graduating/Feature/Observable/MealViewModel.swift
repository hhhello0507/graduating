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
    @Published var meals: [Meal] = []
    
    func fetchMeals(schoolId: Int) {
        MealService.shared.fetchMeals(
            schoolId: schoolId
        )
        .ignoreError()
        .assign(to: \.meals, on: self)
        .store(in: &subscriptions)
    }
}
