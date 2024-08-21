import Combine
import Moya

enum SchoolEndpoint: Endpoint {
    case getSchools
    case getGraduating(id: Int)
}

extension SchoolEndpoint {
    
    static let provider = MoyaProvider<SchoolEndpoint>(session: session)
    
    var host: String { "school" }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getSchools: .get - "" - .requestPlain
        case .getGraduating(let id): .get - "graduating" - ["id": id].toURLParameters()
        }
    }
}

final class SchoolService: Service<SchoolEndpoint> {
    
    static let shared = SchoolService()
    
    func getSchools() -> AnyPublisher<[School], APIError> {
        performRequest(.getSchools, res: [School].self)
    }
    
    func getGraduating(id: Int) -> AnyPublisher<Graduating, APIError> {
        performRequest(.getGraduating(id: id), res: Graduating.self)
    }
}
