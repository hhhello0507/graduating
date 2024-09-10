//
//  MealService.swift
//  Data
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation
import Combine
import MyMoya
import Moya
import Model

public enum MealEndpoint: MyTarget {
    
    case fetchMeals(schoolId: Int)
}

extension MealEndpoint {
    
    static public var provider = MoyaProvider<MealEndpoint>()
    
    public var host: String {
        "meals"
    }
    
    public var route: Route {
        switch self {
        case .fetchMeals(let schoolId): .get("\(schoolId)")
        }
    }
}

public struct MealService {
    public static let shared = Self()
    private let requestManager = DefaultRequestManager<MealEndpoint>()

    public func fetchMeals(schoolId: Int) -> ObservableResult<[Meal]> {
        requestManager.performRequest(.fetchMeals(schoolId: schoolId), res: [Meal].self).observe()
    }
}
