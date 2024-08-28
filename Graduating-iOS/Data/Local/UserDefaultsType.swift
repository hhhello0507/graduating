//
//  UserDefault.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Foundation
import MyShared

public enum UserDefaultsType: String, UserDefaultsProtocol {
    case school
    case grade
    case graduating
    
    public var userDefaults: UserDefaults {
        UserDefaults.graduating
    }
}
