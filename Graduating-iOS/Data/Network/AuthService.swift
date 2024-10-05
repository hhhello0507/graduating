import Combine

import Model

import Moya
import MyMoya

enum AuthEndpoint {
    case oauth2SignIn(OAuth2SignInReq)
    case refresh(RefreshReq)
}

extension AuthEndpoint: MyTarget {
    var host: String { "auth" }
    var route: Route {
        switch self {
        case .oauth2SignIn(let req):
                .post("sign-in/oauth2")
                .task(req.toJSONParameters())
        case .refresh(let req):
                .post("refresh")
                .task(req.toJSONParameters())
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .oauth2SignIn:
                .none
        case .refresh:
                .none
        }
    }
}

public class AuthService {
    public static let shared = AuthService()
    
    public func oauth2SignIn(_ req: OAuth2SignInReq) -> AnyPublisher<Token, MoyaError> {
        runner.deepDive(AuthEndpoint.oauth2SignIn(req), res: Token.self)
    }
    
    public func refresh(_ req: RefreshReq) -> AnyPublisher<Token, MoyaError> {
        runner.deepDive(AuthEndpoint.refresh(req), res: Token.self)
    }
}
