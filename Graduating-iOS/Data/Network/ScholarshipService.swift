import Combine
import Moya
import MyMoya
import Shared

enum ScholarshipEndpoint {
    case getScholarships
}

extension ScholarshipEndpoint: MyTarget {
    var host: String { "scholarships" }
    var route: Route {
        switch self {
        case .getScholarships:
                .get()
        }
    }
}

public final class ScholarshipService {
    public static let shared = ScholarshipService()
    
    public func getScholarships() -> AnyPublisher<[Scholarship], APIError> {
        runner.deepDive(ScholarshipEndpoint.getScholarships, res: [Scholarship].self)
    }
}
