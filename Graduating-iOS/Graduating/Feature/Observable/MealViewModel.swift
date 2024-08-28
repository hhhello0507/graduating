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

public final class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    var subscriptions = Set<AnyCancellable>()
    
    func fetchMeals(schoolId: Int) {
        MealService.shared.fetchMeals(
            .init(schoolId: schoolId)
        )
        .sink { result in
            
        } receiveValue: { res in
            self.meals = res
        }
        .store(in: &subscriptions)
    }
    
    deinit {
        subscriptions.forEach {
            $0.cancel()
        }
    }
}
