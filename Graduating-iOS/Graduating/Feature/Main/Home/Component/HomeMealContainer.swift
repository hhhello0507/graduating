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
        VStack(spacing: 0) {
            ForEach(meals, id: \.id) { meal in
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
            }
        }
        .padding(16)
        .background(Colors.Background.normal)
        .cornerRadius(28, corners: .allCorners)
    }
}
