import Combine
import Moya
import MyMoya
import Shared

public enum SchoolEndpoint: MyTarget {
    case getSchools
}

public extension SchoolEndpoint {
    var host: String {
        "school"
    }
    
    var route: Route {
        switch self {
        case .getSchools: .get()
        }
    }
    
    var authorization: Authorization {
        .none
    }
}

public struct SchoolService {
    public static let shared = Self()
    
    public func getSchools() -> AnyPublisher<[School], APIError> {
        runner.deepDive(SchoolEndpoint.getSchools, res: [School].self)
    }
}
