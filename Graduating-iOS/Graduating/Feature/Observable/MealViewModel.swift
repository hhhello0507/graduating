import Combine
import Foundation

import Model
import Data

public final class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    let subscriptionManager = SubscriptionManager()
}

extension MealViewModel {
    func fetchMeals(schoolId: Int) {
        MealService.shared.fetchMeals(
            schoolId: schoolId
        )
        .ignoreError()
        .assign(to: \.meals, on: self)
        .store(in: &subscriptionManager.subscriptions)
    }
}
