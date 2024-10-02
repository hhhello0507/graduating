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
                    if let meals = viewModel.meals {
                        if meals.isEmpty {
                            Text("급식이 없어요")
                                .myFont(.bodyM)
                                .foreground(Colors.Label.assistive)
                                .frame(height: 60)
                        } else {
                            HomeMealContainer(meals: meals)
                                .padding(.bottom, 72) // for ScrollView
                        }
                    } else if !viewModel.mealsFetchFailure {
                        ProgressView()
                            .padding(.top, 100)
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
