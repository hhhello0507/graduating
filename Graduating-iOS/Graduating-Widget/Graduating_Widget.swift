//
//  Graduating_Widget.swift
//  Graduating-Widget
//
//  Created by hhhello0507 on 8/24/24.
//

import WidgetKit
import SwiftUI

struct Graduating_WidgetEntryView: View {
    var entry: GraduatingProvider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
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
