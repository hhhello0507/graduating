import SwiftUI
import Shared
import MyDesignSystem

struct MealView {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var viewModel: MealViewModel
}

extension MealView: View {
    var body: some View {
        MyTopAppBar.default(title: "급식") { insets in
            ScrollView {
                viewModel.meals.makeView {
                    ProgressView()
                } success: { meals in
                    if meals.isEmpty {
                        Text("급식이 없어요 😰")
                            .foreground(Colors.Label.assistive)
                            .myFont(.bodyM)
                            .padding(.bottom, 108)
                    } else {
                        HomeMealContainer(meals: meals)
                            .padding(.bottom, 72) // for ScrollView
                    }
                } failure: { _ in
                    Text("급식을 불러올 수 없어요 🫠")
                        .foreground(Colors.Label.assistive)
                        .myFont(.bodyM)
                        .padding(.bottom, 108)
                }
                .padding(insets)
            }
            .refreshable {
                viewModel.fetchMeals()
            }
        }
    }
}
