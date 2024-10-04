import Combine
import Foundation

import Model
import Data

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
