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
    
    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
