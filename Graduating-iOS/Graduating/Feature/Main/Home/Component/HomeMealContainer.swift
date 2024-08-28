//
//  HomeMealContainer.swift
//  Graduating
//
//  Created by hhhello0507 on 8/28/24.
//

import SwiftUI
import Model
import MyDesignSystem

public struct HomeMealContainer: View {
    
    private let meals: [Meal]
    
    init(meals: [Meal]) {
        self.meals = meals
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            ForEach(meals, id: \.id) { meal in
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
                        let menus = meal.menu.split(separator: "<br/>")
                        ForEach(Array(menus.enumerated()), id: \.offset) { index, menu in
                            Text(menu)
                                .myFont(.bodyR)
                                .foreground(Colors.Label.normal)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(12)
                .background {
                    Colors.Background.neutral.box.color
                        .opacity(0.25)
                }
                .cornerRadius(18, corners: .allCorners)
            }
        }
        .background(Colors.Background.normal)
    }
}
