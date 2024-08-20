//
//  UserDefault.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Foundation

public enum UserDefaultsType: String {
    case schoolName
    case grade
}

extension UserDefaultsType {
    var value: Any? {
        get {
            UserDefaults.standard.value(forKey: self.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: self.rawValue)
        }
    }
}
