import Foundation
import Combine
import MyMoya
import Moya
import Shared

public enum MealEndpoint: MyTarget {
    case fetchMeals(_ req: GetMealReq)
}

extension MealEndpoint {
    public var host: String { "meals" }
    public var route: Route {
        switch self {
        case .fetchMeals(let req):
                .get()
                .task(req.toURLParameters())
        }
    }
    
    public var authorization: Authorization {
        switch self {
        case .fetchMeals:
                .refresh
        }
    }
}

public struct MealService {
    public static let shared = Self()

    public func fetchMeals(_ req: GetMealReq) -> AnyPublisher<[Meal], APIError> {
        runner.deepDive(MealEndpoint.fetchMeals(req), res: [Meal].self)
    }
}
