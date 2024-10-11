import Combine
import Foundation
import Data
import Shared

public final class MealViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Published var meals: Resource<[Meal]> = .idle

    var isFirstOnAppear: Bool = true
    
    @Published var selectedDate: Date = .now {
        didSet {
            self.fetchMeals(date: selectedDate)
        }
    }
    @Published var selectedCalendar: Date = .now
}

extension MealViewModel: OnAppearProtocol {
    func fetchAllData() {
        fetchMeals(date: selectedDate)
    }
}

extension MealViewModel {
    func fetchMeals(date: Date) {
        MealService.shared.fetchMeals(
            .init(date: date)
        )
        .map {
            $0.sorted {
                ($0.mealType?.priority ?? 0) < ($1.mealType?.priority ?? 0)
            }
        }
        .resource(\.meals, on: self)
        .ignoreError()
        .silentSink()
        .store(in: &subscriptions)
    }
}
