import Combine
import Moya

enum SchoolEndpoint: Endpoint {
    case getSchools
}

extension SchoolEndpoint {
    
    static let provider = MoyaProvider<SchoolEndpoint>(session: session)
    
    var host: String { "school" }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getSchools: .get - "" - .requestPlain
        }
    }
}

final class SchoolService: Service<SchoolEndpoint> {
    
    static let shared = SchoolService()
    
    func getSchools() -> AnyPublisher<[School], APIError> {
        performRequest(.getSchools, res: [School].self)
    }
}
