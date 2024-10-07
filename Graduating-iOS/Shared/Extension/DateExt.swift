//
//  DateExt.swift
//  Shared
//
//  Created by hhhello0507 on 8/24/24.
//

import Foundation

public extension Date {
    func adjustedEndAt(for currentGrade: Int, limit: Int) -> Date? {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        
        guard calendar.date(from: components) != nil else {
            return nil
        }

        let admissionYear = components.year! + limit - currentGrade
        components.year = admissionYear
        return calendar.date(from: components)
    }
}
