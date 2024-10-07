import Combine
import Foundation
import Data
import Shared

public final class MealViewModel: ObservableObject {
    @Published var meals: Resource<[Meal]> = .idle
    var subscriptions = Set<AnyCancellable>()
    var isFirstOnAppear: Bool = true
}

extension MealViewModel {
    func refresh() {
        fetchAllData()
    }
}

extension MealViewModel: OnAppearProtocol {
    func fetchAllData() {
        MealService.shared.fetchMeals()
            .resource(\.meals, on: self)
            .ignoreError()
            .silentSink()
            .store(in: &subscriptions)
    }
}
