//
//  CodableExt.swift
//  Graduating
//
//  Created by hhhello0507 on 8/21/24.
//

import Foundation

let localDateTimeMSFormatter = DateFormatter("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
let localDateTimeFormatter = DateFormatter("yyyy-MM-dd'T'HH:mm:ss")
let localDateFormatter = DateFormatter("yyyy-MM-dd")
let localDateFormatter1 = DateFormatter("yyyyMMdd")

let dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.custom { date, encoder in
    var container = encoder.singleValueContainer()
    let dateStr = localDateTimeMSFormatter.string(from: date)
    try container.encode(date)
}

let dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.custom { decoder in
    let container = try decoder.singleValueContainer()
    let dateStr = try container.decode(String.self)
    
    return if let date = localDateTimeMSFormatter.date(from: dateStr) {
        date
    } else if let date = localDateTimeFormatter.date(from: dateStr) {
        date
    } else if let date = localDateFormatter.date(from: dateStr) {
        date
    } else if let date = localDateFormatter1.date(from: dateStr) {
        date
    } else {
        let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format")
        throw DecodingError.dataCorrupted(context)
    }
}

let myDecoder = JSONDecoder().then { decoder in
    decoder.dateDecodingStrategy = dateDecodingStrategy
}

let myEncoder = JSONEncoder().then { encoder in
    encoder.dateEncodingStrategy = dateEncodingStrategy
}

extension Encodable {
    func encoded() -> String? {
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        encoder.dateEncodingStrategy = .formatted(formatter)
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}

extension Decodable {
    static func decode(_ str: String) -> Self? {
        guard let data = str.data(using: .utf8) else {
            return nil
        }
        return try? myDecoder.decode(Self.self, from: data)
    }
}
