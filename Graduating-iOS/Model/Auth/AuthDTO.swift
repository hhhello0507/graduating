//
//  OAuth2SignInReq.swift
//  Model
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation

public struct OAuth2SignInReq: ReqProtocol {
    public let platformType: PlatformType
    public let code: String
    
    public init(platformType: PlatformType, code: String) {
        self.platformType = platformType
        self.code = code
    }
}

public struct RefreshReq: ReqProtocol {
    public let refreshToken: String
    
    public init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
