import Foundation

struct School: Codable, Hashable {
    let id: Int
    let name: String
    let type: SchoolType?
    let cityName: String
    let postalCode: String
    let address: String
    let addressDetail: String
    let phone: String
    let website: String
    let createdAt: String
    let anniversary: String
}

enum SchoolType: String, Codable {
    case HIGH
    case MIDDLE
    case ELEMENTARY
}
