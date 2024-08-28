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
    
    case fetchMeals(FetchMealReq)
}

extension MealEndpoint {
    
    static public var provider = MoyaProvider<MealEndpoint>()
    
    public var host: String {
        "meal"
    }
    
    public var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .fetchMeals(let req):
                .get - "" - req.toURLParameters()
        }
    }
}

public final class MealService: Service<MealEndpoint> {
    public func fetchMeals(_ req: FetchMealReq) -> Result<[Meal]> {
        performRequest(.fetchMeals(req), res: [Meal].self)
    }
    
    public static let shared = MealService(allowLog: true)
}
