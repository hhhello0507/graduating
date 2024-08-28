import SwiftUI
import MyDesignSystem
import Model

struct MealCell: View {
    
    private let meal: Meal
    
    init(
        meal: Meal
    ) {
        self.meal = meal
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
//                DodamTag(type.label, type: .primary)
                Spacer()
                Text("\(Int(meal.calorie))Kcal")
                    .myFont(.labelM)
                    .foreground(Colors.Label.alternative)
            }
            Text(meal.menu.split(separator: "<br/>").joined(separator: "\n"))
                .myFont(.bodyB)
                .foreground(Colors.Label.normal)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Colors.Background.normal)
        .cornerRadius(28, corners: .allCorners)
    }
}
