import MyMoya
import Foundation

extension MyMoya.MyTarget {
    public var baseURL: URL {
        URL(string: baseUrl)!
            .appendingPathComponent(host)
    }
}
