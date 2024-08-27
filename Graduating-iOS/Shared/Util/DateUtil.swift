import Foundation

public func nextFebruaryFirst(from date: Date) -> Date? {
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: date)
    let currentMonth = calendar.component(.month, from: date)
    
    var nextYear = currentYear
    if currentMonth >= 2 {
        nextYear += 1
    }
    
    let februaryFirstComponents = DateComponents(year: nextYear, month: 2, day: 1)
    return calendar.date(from: februaryFirstComponents)
}
