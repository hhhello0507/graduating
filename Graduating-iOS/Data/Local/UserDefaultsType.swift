//
//  UserDefault.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Foundation

public enum UserDefaultsType: String {
    case school
    case grade
    case graduating
}

public extension UserDefaults {
    static var graduating: UserDefaults {
        let appGroupId = "group.hhhello0507.graduating"
        return UserDefaults(suiteName: appGroupId) ?? .standard
    }
}

public extension UserDefaultsType {
    var value: Any? {
        UserDefaults.graduating.value(forKey: self.rawValue)
    }
    
    func set(_ value: Any?) {
        UserDefaults.graduating.setValue(value, forKey: self.rawValue)
    }
}
