import Foundation
import MyFoundationUtil

public extension Decodable {
    static func decode(_ str: String) -> Self? {
        guard let data = str.data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder.myDecoder.decode(Self.self, from: data)
    }
}
