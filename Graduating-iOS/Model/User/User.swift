import Foundation

public struct User: ModelProtocol {
    public let id: Int
    public let username: String
    public let nickname: String
    public let graduatingYear: Int
    public let school: School
    
    public init(
        id: Int,
        username: String,
        nickname: String,
        graduatingYear: Int,
        school: School
    ) {
        self.id = id
        self.username = username
        self.nickname = nickname
        self.graduatingYear = graduatingYear
        self.school = school
    }
}
