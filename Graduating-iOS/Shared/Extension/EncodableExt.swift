import Foundation
import MyFoundationUtil

public extension Encodable {
    func encoded() -> String? {
        let encoder = JSONEncoder.myEncoder
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        encoder.dateEncodingStrategy = .formatted(formatter)
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
