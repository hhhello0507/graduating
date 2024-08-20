import Foundation

public extension Date {
    
    func parseString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
    
    var remainingTimeText: String {
        let now = Date()
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: now, to: self)
        
        return if let days = components.day, days > 0 {
            "\(days)일"
        } else if let hours = components.hour, let minutes = components.minute {
            "\(hours)시간 \(minutes)분"
        } else {
            "-"
        }
    }
    
    subscript(components: Calendar.Component) -> Int? {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "ko_KR")
        return calendar.dateComponents([components], from: self).value(for: components)
    }
    
    func equals(_ other: Date, components: Set<Calendar.Component>) -> Bool {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "ko_KR")
        let selfComponents = calendar.dateComponents(components, from: self)
        let otherComponents = calendar.dateComponents(components, from: other)
        return selfComponents == otherComponents
    }
    
    var weeklyDates: [Date] {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "ko_KR")
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return (0..<7).compactMap { number in
            if let date = calendar.date(byAdding: .day, value: number, to: startOfWeek) {
                date
            } else {
                nil
            }
        }
    }
    
    var range: Int? {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: self)?.count
    }
}
