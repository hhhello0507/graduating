import Foundation

public struct School: ModelProtocol {
    public let id: Int
    public let name: String
    public let type: SchoolType?
    public let cityName: String
    public let postalCode: String
    public let address: String
    public let addressDetail: String
    public let phone: String
    public let website: String
    public let createdAt: String
    public let anniversary: String
    
    public init(id: Int, name: String, type: SchoolType?, cityName: String, postalCode: String, address: String, addressDetail: String, phone: String, website: String, createdAt: String, anniversary: String) {
        self.id = id
        self.name = name
        self.type = type
        self.cityName = cityName
        self.postalCode = postalCode
        self.address = address
        self.addressDetail = addressDetail
        self.phone = phone
        self.website = website
        self.createdAt = createdAt
        self.anniversary = anniversary
    }
}
