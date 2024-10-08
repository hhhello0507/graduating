import Foundation

public struct User: ModelProtocol {
    public let id: Int
    public let email: String
    public let nickname: String
    public let graduatingYear: Int
    public let school: School
    
    public init(
        id: Int,
        email: String,
        nickname: String,
        graduatingYear: Int,
        school: School
    ) {
        self.id = id
        self.email = email
        self.nickname = nickname
        self.graduatingYear = graduatingYear
        self.school = school
    }
}

public extension User {
    var graduating: Graduating? {
        guard let type = self.school.type else { return nil }
        return Graduating(graduatingYear: self.graduatingYear, schoolType: type)
    }
}
