import WidgetKit
import SwiftUI
import Shared
import MyDesignSystem

public struct MealWidgetEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    private let entry: MealEntry
    
    public init(
        entry: MealEntry
    ) {
        self.entry = entry
    }
    
    public var body: some View {
        let mealType = MealType.from(.now) ?? .breakfast
        let meal = entry.meal
        VStack(spacing: 4) {
            HStack {
                Text(mealType.korean)
                    .foreground(Colors.Static.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Colors.Primary.normal)
                    .cornerRadius(100, corners: .allCorners)
                    .font(.footnote)
                Spacer()
                if let meal {
                    Text("\(Int(meal.calorie.rounded()))Kcal")
                        .font(.caption)
                        .foreground(Colors.Label.alternative)
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                if let meal {
                    if meal.menu.isEmpty {
                        MealMenuText(text: "오늘은\n급식이 없어요", isMealEmpty: false)
                    } else {
                        HStack {
                            if widgetFamily == .systemSmall {
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach(0..<min(meal.details.count, 6), id: \.self) { idx in
                                        MealMenuText(text: meal.details.count > 6 && idx == 6 ? "..." : meal.details[idx].name)
                                    }
                                }
                            } else {
                                ForEach(meal.menu.splitArray(position: 6), id: \.self) { meals in
                                    VStack(alignment: .leading, spacing: 0) {
                                        ForEach(meals, id: \.self) { meal in
                                            MealMenuText(text: meal.name)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    MealMenuText(text: "급식을\n불러올 수 없어요", isMealEmpty: false)
                }
            }
            .padding(8)
            .frame(maxHeight: .infinity)
            .background(Colors.Background.normal)
            .cornerRadius(18, corners: .allCorners)
        }
        .background(Colors.Background.neutral)
    }
}

public struct MealWidget: Widget {
    private let widgetFamilyList: [WidgetFamily] = if #available(iOSApplicationExtension 16.0, *) {
        [.systemSmall, .systemMedium, .accessoryRectangular, .accessoryCircular]
    } else {
        [.systemSmall, .systemMedium]
    }
    public static let kind = "Meal_Widget"
    
    public init() {}
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Self.kind,
            provider: MealProvider()
        ) { entry in
            MealWidgetEntryView(entry: entry)
                .safeContainerBackground(color: Colors.Background.neutral)
        }
        .configurationDisplayName("급식")
        .description("오늘 우리 학교 급식은?")
        .contentMarginsDisabled()
        .supportedFamilies(widgetFamilyList)
    }
}
