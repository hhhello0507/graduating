//
//  MealView.swift
//  Graduating
//
//  Created by hhhello0507 on 9/6/24.
//

import SwiftUI
import MyDesignSystem

struct MealView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var viewModel: MealViewModel
    
    var body: some View {
        MyTopAppBar.default(title: "급식") { insets in
            ScrollView {
                Group {
                    if viewModel.meals.isEmpty {
                        ProgressView()
                            .padding(.top, 100)
                    } else {
                        HomeMealContainer(meals: viewModel.meals)
                            .padding(.bottom, 72) // for ScrollView
                    }
                }
                .padding(insets)
            }
            .refreshable {
                guard let schoolId = appState.school?.id else {
                    return
                }
                viewModel.fetchMeals(schoolId: schoolId)
            }
        }
    }
}
