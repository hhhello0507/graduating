//
//  MealType.swift
//  Model
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation

public enum MealType: String, ModelProtocol {
    case BREAKFAST
    case LAUNCH
    case DINNER
    
    public var korean: String {
        switch self {
        case .BREAKFAST: "조식"
        case .LAUNCH: "중식"
        case .DINNER: "석식"
        }
    }
}
