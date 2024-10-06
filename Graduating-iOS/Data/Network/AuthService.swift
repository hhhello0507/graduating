import Combine
import Model
import Moya
import MyMoya

enum AuthEndpoint {
    case signUp(SignUpReq)
    case signIn(SignInReq)
    case refresh(RefreshReq)
}

extension AuthEndpoint: MyTarget {
    var host: String { "auth" }
    var route: Route {
        switch self {
        case .signUp(let req):
                .post("sign-up")
                .task(req.toJSONParameters())
        case .signIn(let req):
                .post("sign-in")
                .task(req.toJSONParameters())
        case .refresh(let req):
                .post("refresh")
                .task(req.toJSONParameters())
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .signUp:
                .none
        case .signIn:
                .none
        case .refresh:
                .none
        }
    }
}

public class AuthService {
    public static let shared = AuthService()
    
    public func signUp(_ req: SignUpReq) -> AnyPublisher<Token, APIError> {
        runner.deepDive(AuthEndpoint.signUp(req), res: Token.self)
    }
    
    public func signIn(_ req: SignInReq) -> AnyPublisher<Token, APIError> {
        runner.deepDive(AuthEndpoint.signIn(req), res: Token.self)
    }
    
    public func refresh(_ req: RefreshReq) -> AnyPublisher<Token, APIError> {
        runner.deepDive(AuthEndpoint.refresh(req), res: Token.self)
    }
}
