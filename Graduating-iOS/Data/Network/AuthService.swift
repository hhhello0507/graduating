import Combine
import Moya
import MyMoya
import Shared

enum AuthEndpoint {
    case signIn(SignInReq)
    case signUp(SignUpReq)
    case refresh(RefreshReq)
}

extension AuthEndpoint: MyTarget {
    var host: String { "auth" }
    var route: Route {
        switch self {
        case .signIn(let req):
                .post("sign-in")
                .task(req.toJSONParameters())
        case .signUp(let req):
                .post("sign-up")
                .task(req.toJSONParameters())
        case .refresh(let req):
                .post("refresh")
                .task(req.toJSONParameters())
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .signIn:
                .none
        case .signUp:
                .refresh
        case .refresh:
                .none
        }
    }
}

public class AuthService {
    public static let shared = AuthService()
    
    public func signIn(_ req: SignInReq) -> AnyPublisher<Token, APIError> {
        runner.deepDive(AuthEndpoint.signIn(req), res: Token.self)
    }
    
    public func signUp(_ req: SignUpReq) -> AnyPublisher<Token, APIError> {
        runner.deepDive(AuthEndpoint.signUp(req), res: Token.self)
    }
    
    public func refresh(_ req: RefreshReq) -> AnyPublisher<Token, APIError> {
        runner.deepDive(AuthEndpoint.refresh(req), res: Token.self)
    }
}
