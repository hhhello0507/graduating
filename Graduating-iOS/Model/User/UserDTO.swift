//
//  UserDTO.swift
//  Model
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation

public struct EditUserReq: ReqProtocol {
    public let nickname: String
    public init(nickname: String) {
        self.nickname = nickname
    }
}
