import Foundation

public struct GetMealReq: ReqProtocol {
    public let year: Int
    public let month: Int
    public let day: Int
    
    public init(
        year: Int,
        month: Int,
        day: Int
    ) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    public init(date: Date = .now) {
        self.year = date[.year]
        self.month = date[.month]
        self.day = date[.day]
    }
}
