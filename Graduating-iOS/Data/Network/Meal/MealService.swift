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

public enum MealEndpoint: MyMoya.Endpoint {
    
    case fetchMeals(schoolId: Int)
}

extension MealEndpoint {
    
    static public var provider = MoyaProvider<MealEndpoint>()
    
    public var host: String {
        "meals"
    }
    
    public var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .fetchMeals(let schoolId):
                .get - "\(schoolId)" - .requestPlain
        }
    }
}

public final class MealService: Service<MealEndpoint> {
    public func fetchMeals(schoolId: Int) -> Result<[Meal]> {
        performRequest(.fetchMeals(schoolId: schoolId), res: [Meal].self)
    }
    
    public static let shared = MealService(allowLog: true)
}
