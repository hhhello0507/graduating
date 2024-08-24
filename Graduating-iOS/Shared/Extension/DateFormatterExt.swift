//
//  DateFormatterExt.swift
//  Shared
//
//  Created by hhhello0507 on 8/24/24.
//

import Foundation

public extension DateFormatter {
    convenience init(_ dateFormat: String, locale: Locale = Locale(identifier: "ko_KR")) {
        self.init()
        self.dateFormat = dateFormat
        self.locale = locale
    }
}
