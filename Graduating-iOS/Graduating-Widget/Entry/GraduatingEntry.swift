//
//  GraduatingEntry.swift
//  Graduating
//
//  Created by hhhello0507 on 8/24/24.
//

import WidgetKit

struct GraduatingEntry: TimelineEntry {
    let date: Date
    let remainTime: DateComponents
    let remainTimePercent: Double
}

extension GraduatingEntry {
    static var empty: GraduatingEntry {
        var components = DateComponents()
        if let year = components.year {
            components.setValue(year - 1, for: .year)
        }
        return GraduatingEntry(
            date: .now,
            remainTime: components,
            remainTimePercent: 0.4
        )
    }
}
