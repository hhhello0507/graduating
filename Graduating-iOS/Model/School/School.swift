import Foundation

public struct School: ModelProtocol {
    public var id: Int
    public var name: String
    public var type: SchoolType?
    public var cityName: String
    public var postalCode: String
    public var address: String
    public var addressDetail: String
    public var phone: String
    public var website: String
    public var createdAt: String
    public var anniversary: String
    
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
