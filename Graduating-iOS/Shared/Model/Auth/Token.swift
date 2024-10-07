//
//  Token.swift
//  Model
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation

public struct Token: ModelProtocol {
    public let accessToken: String
    public let refreshToken: String
    public let state: UserState
    
    public init(accessToken: String, refreshToken: String, state: UserState) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.state = state
    }
}
