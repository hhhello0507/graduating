import SwiftUI
import Shared
import MyDesignSystem

public struct HomeMealContainer {
    private let meals: [Meal]
    
    init(meals: [Meal]) {
        self.meals = meals
    }
}

extension HomeMealContainer: View {
    public var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(meals, id: \.id) { meal in
                MealCell(meal: meal)
            }
        }
    }
}

struct MealCell: View {
    let meal: Meal
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                if let mealType = meal.mealType?.korean {
                    Text(mealType)
                        .myFont(.bodyM)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .foreground(Colors.Static.white)
                        .background(Colors.Primary.normal)
                        .cornerRadius(12, corners: .allCorners)
                }
                Spacer()
                Text("\(Int(meal.calorie)) Kcal")
                    .myFont(.labelM)
                    .foreground(Colors.Label.alternative)
            }
            VStack(spacing: 2) {
                ForEach(Array(meal.menu.enumerated()), id: \.offset) { index, menu in
                    Text(menu)
                        .myFont(.labelR)
                        .foreground(Colors.Label.normal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(16)
        .background(Colors.Background.normal)
        .cornerRadius(18, corners: .allCorners)
        .shadow(.evBlack1)
    }
}
