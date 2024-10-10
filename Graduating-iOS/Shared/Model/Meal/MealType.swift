//
//  MealType.swift
//  Model
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation

public enum MealType: String, ModelProtocol {
    case breakfast = "BREAKFAST"
    case lunch = "LUNCH"
    case dinner = "DINNER"
    
    public var korean: String {
        switch self {
        case .breakfast: "조식"
        case .lunch: "중식"
        case .dinner: "석식"
        }
    }
    
    
    public static func from(_ date: Date) -> Self? {
        switch (date[.hour], date[.minute]) {
        case (0...8, _), (8, ..<20):
                .breakfast // 아침: ~ 8:20
        case (8, 21...60), (8...13, _), (13, 0..<30):
                .lunch // 점심: 8:21 ~ 13:30
        case (13, 0...30), (13...19, _), (19, 0..<10):
                .dinner // 저녁: 13:31 ~ 19:10
        default: nil
        }
    }
}
