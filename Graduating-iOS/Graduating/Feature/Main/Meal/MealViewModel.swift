import Combine
import Foundation

import Model
import Data
import Shared

public final class MealViewModel: ObservableObject {
    @Published var meals: Resource<[Meal]> = .idle
    var subscriptions = Set<AnyCancellable>()
}

extension MealViewModel {
    func fetchMeals() {
        MealService.shared.fetchMeals()
            .resource(\.meals, on: self)
            .ignoreError()
            .silentSink()
            .store(in: &subscriptions)
    }
}
