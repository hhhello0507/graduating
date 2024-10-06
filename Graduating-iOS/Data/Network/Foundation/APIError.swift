public enum APIError: Error, Equatable {
    case http(ErrorRes)
    case unknown
    case refreshFailure
}

public struct ErrorRes: Codable, Hashable {
    public let status: Int
    public let message: String
}
