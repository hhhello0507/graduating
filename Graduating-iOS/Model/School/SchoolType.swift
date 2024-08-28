//
//  SchoolType.swift
//  Model
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation

public enum SchoolType: String, ModelProtocol {
    case HIGH
    case MIDDLE
    case ELEMENTARY
    
    public var limit: Int {
        switch self {
        case .HIGH: 3
        case .MIDDLE: 3
        case .ELEMENTARY: 6
        }
    }
}
