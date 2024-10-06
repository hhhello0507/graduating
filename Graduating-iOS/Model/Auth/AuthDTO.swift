public struct SignUpReq: ReqProtocol {
    public let platformType: PlatformType
    public let code: String
    
    public init(
        platformType: PlatformType,
        code: String
    ) {
        self.platformType = platformType
        self.code = code
    }
}

public struct SignInReq: ReqProtocol {
    public let platformType: PlatformType
    public let code: String
    public let nickname: String
    public let graduatingYear: Int
    public let schoolId: Int
    
    public init(
        platformType: PlatformType,
        code: String,
        nickname: String,
        graduatingYear: Int,
        schoolId: Int
    ) {
        self.platformType = platformType
        self.code = code
        self.nickname = nickname
        self.graduatingYear = graduatingYear
        self.schoolId = schoolId
    }
}

public struct RefreshReq: ReqProtocol {
    public let refreshToken: String
    
    public init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
