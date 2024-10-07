import Combine
import Moya
import MyMoya
import Shared

enum UserEndpoint {
    case getMe
    case editUser(EditUserReq)
}

extension UserEndpoint: MyTarget {
    var host: String { "user" }
    var route: Route {
        switch self {
        case .getMe:
                .get("me")
        case .editUser(let req):
                .patch()
                .task(req.toJSONParameters())
        }
    }
}

public class UserService {
    public static let shared = UserService()
    
    public func getMe() -> AnyPublisher<User, APIError> {
        runner.deepDive(UserEndpoint.getMe, res: User.self)
    }
    
    public func editUser(_ req: EditUserReq) -> AnyPublisher<VoidDTO, APIError> {
        runner.deepDive(UserEndpoint.editUser(req), res: VoidDTO.self)
    }
}
