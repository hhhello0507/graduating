import Foundation

public extension DateComponents {
    var prettyText: String {
        var text = ""
        if let year = self.year, year > 0 { text += "\(year)년 " }
        if let month = self.month, month > 0 { text += "\(month)개월 " }
        if let day = self.day, day > 0 { text += "\(day)일 " }
        if let hour = self.hour, hour > 0 { text += "\(hour)시간 " }
        if let minute = self.minute, minute > 0 { text += "\(minute)분 " }
        if let second = self.second, second > 0 {
            let _ = text += "\(second)"
            if let nanosecond = self.nanosecond, nanosecond > 0 {
                let _ = text += ".\(nanosecond / 1_000_000_00)"
            }
            text += "초"
        }
        return text
    }
}
