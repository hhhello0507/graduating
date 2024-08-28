import Combine
import Moya
import Model
import MyMoya

extension MyMoya.Endpoint {
    public var baseUrlString: String {
        baseUrl
    }
}

public enum SchoolEndpoint: MyMoya.Endpoint {
    case getSchools
    case getGraduating(id: Int)
}

public extension SchoolEndpoint {
    
    static let provider = MoyaProvider<SchoolEndpoint>(session: session)
    
    var host: String { "school" }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getSchools: .get - "" - .requestPlain
        case .getGraduating(let id): .get - "graduating" - ["id": id].toURLParameters()
        }
    }
}

public final class SchoolService: Service<SchoolEndpoint> {
    
    public static let shared = SchoolService(allowLog: true)
    
    public func getSchools() -> AnyPublisher<[School], APIError<EmptyErrorResponse>> {
        performRequest(.getSchools, res: [School].self)
    }
    
    public func getGraduating(id: Int) -> AnyPublisher<Graduating, APIError<EmptyErrorResponse>> {
        performRequest(.getGraduating(id: id), res: Graduating.self)
    }
}
