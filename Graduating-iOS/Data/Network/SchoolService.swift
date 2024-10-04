import Combine
import Moya
import Model
import MyMoya

public enum SchoolEndpoint: MyTarget {
    case getSchools
    case getGraduating(id: Int)
}

public extension SchoolEndpoint {
    var host: String {
        "school"
    }
    
    var route: Route {
        switch self {
        case .getSchools: .get()
        case .getGraduating(let id):
                .get("graduating")
                .task(["id": id].toURLParameters())
        }
    }
}

public struct SchoolService {
    
    public static let shared = Self()
    private let runner = DefaultNetRunner<SchoolEndpoint>(
        provider: .init(
            session: MoyaProviderUtil.mySession,
            plugins: MoyaProviderUtil.myPlugins
        )
    )
    
    public func getSchools() -> AnyPublisher<[School], MoyaError> {
        runner.deepDive(.getSchools, res: [School].self)
    }
    
    public func getGraduating(id: Int) -> AnyPublisher<Graduating, MoyaError> {
        runner.deepDive(.getGraduating(id: id), res: Graduating.self)
    }
}
