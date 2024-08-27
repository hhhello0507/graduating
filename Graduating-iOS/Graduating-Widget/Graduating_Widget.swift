//
//  Graduating_Widget.swift
//  Graduating-Widget
//
//  Created by hhhello0507 on 8/24/24.
//

import WidgetKit
import SwiftUI
import MyDesignSystem

struct Graduating_WidgetEntryView: View {
    
    private let entry: GraduatingProvider.Entry

    
    init(entry: GraduatingProvider.Entry) {
        self.entry = entry
    }

    var body: some View {
        VStack {
            Text("졸업까지")
                .font(.caption)
                .foreground(Colors.Label.assistive)
            Text(String(format: "%.7f%%", entry.remainTimePercent * 100))
                .font(.headline)
                .foreground(Colors.Label.normal)
        }
    }
}

struct Graduating_Widget: Widget {
    let kind: String = "Graduating_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: GraduatingProvider()) { entry in
            if #available(iOS 17.0, *) {
                Graduating_WidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                Graduating_WidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("졸업일")
        .description("졸업까지 얼마나 남았는지 알려줍니다")
    }
}
