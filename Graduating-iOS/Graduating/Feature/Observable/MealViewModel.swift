//
//  MealViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation
import Model

public final class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    func fetchMeals() {
        
    }
}
