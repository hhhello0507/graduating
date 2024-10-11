//  Author: hhhello0507
//  Created: 10/7/24


import Foundation

public struct Graduating: ModelProtocol {
    public let graduatingYear: Int
    public let schoolType: SchoolType
    
    public init(
        graduatingYear: Int,
        schoolType: SchoolType
    ) {
        self.graduatingYear = graduatingYear
        self.schoolType = schoolType
    }
}

public extension Graduating {
    var admissionDay: Date {
        return self.firstDay(year: admissionYear)
    }
    
    var admissionYear: Int {
        return self.graduatingYear - self.schoolType.limit
    }
    
    var graduatingDay: Date {
        return self.firstDay(year: graduatingYear)
    }
    
    var remainTime: DateComponents {
        let currentTime = Date.now
        return currentTime.diff([.year, .month, .day, .hour, .minute, .second, .nanosecond], other: graduatingDay)
    }
    
    var remainTimePercent: Double {
        let currentTime = Date.now
        return currentTime.percent(from: admissionDay, to: graduatingDay)
    }
    
    private func firstDay(year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = 1
        dateComponents.day = 1
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)!
    }

}
