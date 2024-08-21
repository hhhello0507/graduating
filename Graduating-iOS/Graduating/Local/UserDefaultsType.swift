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

extension UserDefaultsType {
    var value: Any? {
        UserDefaults.standard.value(forKey: self.rawValue)
    }
    
    func set(_ value: Any?) {
        UserDefaults.standard.setValue(value, forKey: self.rawValue)
    }
}
