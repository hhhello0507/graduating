public enum SchoolType: String, ModelProtocol {
    case high = "HIGH"
    case middle = "MIDDLE"
    case elementary = "ELEMENTARY"
}

public extension SchoolType {
    var limit: Int {
        switch self {
        case .high:
            3
        case .middle:
            3
        case .elementary:
            6
        }
    }
}
