import Foundation
import Combine
import MyMoya
import Moya
import Shared

public enum MealEndpoint: MyTarget {
    case fetchMeals
}

extension MealEndpoint {
    public var host: String { "meals" }
    public var route: Route {
        switch self {
        case .fetchMeals:
                .get()
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

    public func fetchMeals() -> AnyPublisher<[Meal], APIError> {
        runner.deepDive(MealEndpoint.fetchMeals, res: [Meal].self)
    }
}
