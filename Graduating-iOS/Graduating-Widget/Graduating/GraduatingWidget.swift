//
//  Graduating_Widget.swift
//  Graduating-Widget
//
//  Created by hhhello0507 on 8/24/24.
//

import WidgetKit
import SwiftUI
import MyDesignSystem

struct GraduatingWidgetEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    private let entry: GraduatingProvider.Entry
    
    init(entry: GraduatingProvider.Entry) {
        self.entry = entry
    }
    
    private var isSmall: Bool {
        [.systemSmall].contains(widgetFamily)
    }
    
    var body: some View {
        VStack {
            Text("졸업까지")
                .font(.caption)
                .foreground(Colors.Label.assistive)
            Text(String(format: isSmall ? "%.3f%%" : "%.7f%%", entry.remainTimePercent * 100))
                .font(.title)
                .foreground(Colors.Label.normal)
            Text(entry.remainTime.prettyText)
                .font(isSmall ? .caption2 : .caption)
                .foreground(Colors.Label.alternative)
                .multilineTextAlignment(.center)
        }
        .background(Colors.Background.neutral)
        .padding(15)
    }
}

public struct GraduatingWidget: Widget {
    private let widgetFamilyList: [WidgetFamily] = if #available(iOSApplicationExtension 16.0, *) {
        [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryCircular]
    } else {
        [.systemSmall, .systemMedium]
    }
    public static let kind: String = "Graduating_Widget"
    
    public init() {}

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: Self.kind, provider: GraduatingProvider()) { entry in
            GraduatingWidgetEntryView(entry: entry)
                .safeContainerBackground(color: Colors.Background.neutral)
        }
        .configurationDisplayName("졸업일")
        .description("졸업까지 얼마나 남았는지 알려줍니다")
        .contentMarginsDisabled()
        .supportedFamilies(widgetFamilyList)
    }
}
