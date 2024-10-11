import Combine
import Foundation
import Data
import Shared

public final class MealViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Published var meals: Resource<[Meal]> = .idle

    var isFirstOnAppear: Bool = true
    
    @Published var selectedDate: Date = .now
    @Published var selectedCalendar: Date = .now
    
    init() {
        self.observe()
    }
}

extension MealViewModel {
    func refresh() {
        fetchAllData()
    }
    
    func observe() {
        self.$selectedDate.sink { _ in
            self.fetchAllData()
        }
        .store(in: &subscriptions)
    }
}

extension MealViewModel: OnAppearProtocol {
    func fetchAllData() {
        MealService.shared.fetchMeals(
            .init(date: selectedDate)
        )
        .map {
            $0.sorted {
                ($0.mealType?.priority ?? 0) > ($1.mealType?.priority ?? 0)
            }
        }
        .resource(\.meals, on: self)
        .ignoreError()
        .silentSink()
        .store(in: &subscriptions)
    }
}
