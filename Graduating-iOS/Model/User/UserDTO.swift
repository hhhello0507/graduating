//
//  UserDTO.swift
//  Model
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation

public struct EditUserReq: ReqProtocol {
    public let nickname: String?
    public let graduatingYear: Int?
    public let schoolId: Int?
    
    public init(
        nickname: String? = nil,
        graduatingYear: Int? = nil,
        schoolId: Int? = nil
    ) {
        self.nickname = nickname
        self.graduatingYear = graduatingYear
        self.schoolId = schoolId
    }
}

public enum UserState: String, ModelProtocol {
    case pending = "PENDING"
    case none = "NONE"
}
