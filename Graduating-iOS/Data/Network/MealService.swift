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
import Shared

public enum MealEndpoint: MyTarget {
    
    case fetchMeals(schoolId: Int)
}

extension MealEndpoint {
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
    private let runner = DefaultNetRunner<MealEndpoint>(
        provider: .init(
            session: MoyaProviderUtil.mySession,
            plugins: MoyaProviderUtil.myPlugins
        )
    )

    public func fetchMeals(schoolId: Int) -> AnyPublisher<[Meal], MoyaError> {
        runner.deepDive(.fetchMeals(schoolId: schoolId), res: [Meal].self)
    }
}
