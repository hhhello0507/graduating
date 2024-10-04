//
//  UserService.swift
//  Data
//
//  Created by hhhello0507 on 10/4/24.
//

import Combine

import Model

import Moya
import MyMoya

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
    let netRunnner = DefaultNetRunner<UserEndpoint>(
        provider: .init(
            session: MoyaProviderUtil.myAuthSession,
            plugins: MoyaProviderUtil.myPlugins
        )
    )
    
    public func getMe() -> AnyPublisher<User, MoyaError> {
        return netRunnner.deepDive(.getMe, res: User.self)
    }
    
    public func editUser(_ req: EditUserReq) -> AnyPublisher<VoidDTO, MoyaError> {
        netRunnner.deepDive(.editUser(req), res: VoidDTO.self)
    }
}
