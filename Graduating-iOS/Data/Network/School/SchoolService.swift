import Combine
import Moya
import Model
import MyMoya

public enum SchoolEndpoint: MyTarget {
    case getSchools
    case getGraduating(id: Int)
}

public extension SchoolEndpoint {
    
    static let provider = MoyaProvider<Self>(session: session)
    
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
    
    private let requestManager = DefaultRequestManager<SchoolEndpoint>()
    
    public func getSchools() -> ObservableResult<[School]> {
        requestManager.performRequest(.getSchools, res: [School].self).observe()
    }
    
    public func getGraduating(id: Int) -> ObservableResult<Graduating> {
        requestManager.performRequest(.getGraduating(id: id), res: Graduating.self).observe()
    }
}
