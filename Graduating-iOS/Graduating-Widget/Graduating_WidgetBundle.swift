import WidgetKit
import SwiftUI
import MyDesignSystem

@main
struct Graduating_WidgetBundle: WidgetBundle {
    init() {
        if let theme = UserDefaults.graduating.value(forKey: "theme") as? Int,
           let pallete = Palette(rawValue: theme) {
            CustomPalette.Provider()
                .updateColor(pallete: pallete)
        }
    }
    var body: some Widget {
        GraduatingWidget()
        MealWidget()
    }
}
