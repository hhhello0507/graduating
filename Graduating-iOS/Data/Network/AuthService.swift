//
//  AuthService.swift
//  Data
//
//  Created by hhhello0507 on 10/4/24.
//

import MyMoya
import Model
import Moya
import Combine

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
}

public class AuthService {
    public static let shared = AuthService()
    let netRunner = DefaultNetRunner<AuthEndpoint>()
    
    public func oauth2SignIn(_ req: OAuth2SignInReq) -> AnyPublisher<Token, MoyaError> {
        netRunner.deepDive(.oauth2SignIn(req), res: Token.self)
    }
    
    public func refresh(_ req: RefreshReq) -> AnyPublisher<Token, MoyaError> {
        netRunner.deepDive(.refresh(req), res: Token.self)
    }
}
