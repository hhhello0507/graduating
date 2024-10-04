//
//  User.swift
//  Model
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation

public struct User: ModelProtocol {
    public let username: String
    public let nickname: String?
    
    public init(username: String, nickname: String?) {
        self.username = username
        self.nickname = nickname
    }
}
