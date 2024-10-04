//
//  AuthService.swift
//  Data
//
//  Created by hhhello0507 on 10/4/24.
//

import MyMoya
import Model

public enum AuthEndpoint {
    case oauth2SignIn(OAuth2SignInReq)
    case refresh(RefreshReq)
}

extension AuthEndpoint: MyTarget {
    public var host: String { "auth" }
    public var route: Route {
        switch self {
        case .oauth2SignIn(let req):
                .post("sign-in/auth2")
                .task(req.toJSONParameters())
        case .refresh(let req):
                .post("refresh")
                .task(req.toJSONParameters())
        }
    }
}

//public e
