import Combine
import Moya
import Model
import MyMoya

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
}

public struct SchoolService {
    public static let shared = Self()
    
    public func getSchools() -> AnyPublisher<[School], MoyaError> {
        runner.deepDive(SchoolEndpoint.getSchools, res: [School].self)
    }
}
