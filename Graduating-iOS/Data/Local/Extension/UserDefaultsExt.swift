import Foundation

public extension UserDefaults {
    static var graduating: UserDefaults {
        let appGroupId = "group.hhhello0507.graduating"
        return UserDefaults(suiteName: appGroupId) ?? .standard
    }
}
