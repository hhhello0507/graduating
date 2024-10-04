import Foundation

public extension UserDefaults {
    static var graduating: UserDefaults {
        let appGroupId = "group.hhhello0507.graduating"
        return UserDefaults(suiteName: appGroupId) ?? .standard
    }
    
    var accessToken: String? {
        get { self.string(forKey: "accessToken") }
        set { self.set(newValue, forKey: "accessToken") }
    }
}
