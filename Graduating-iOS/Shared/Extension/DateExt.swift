//
//  DateExt.swift
//  Shared
//
//  Created by hhhello0507 on 8/24/24.
//

import Foundation

public extension Date {
    
    // 현재 학년을 기준으로 입학일을 구하는 함수
    static func getStartAt(for currentGrade: Int) -> Date? {
        let calendar = Calendar.current
        let now = Date()

        // 현재 연도의 3월 1일 구하기
        var components = calendar.dateComponents([.year], from: now)
        components.month = 3
        components.day = 1
        
        guard calendar.date(from: components) != nil else {
            return nil
        }

        // 현재 학년에 따른 입학 연도 계산
        let admissionYear = components.year! - (currentGrade - 1)

        // 입학 연도의 3월 1일 구하기
        components.year = admissionYear
        return calendar.date(from: components)
    }
    
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
