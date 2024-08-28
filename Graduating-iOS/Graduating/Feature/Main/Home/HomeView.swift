import SwiftUI
import MyDesignSystem
import Combine
import Shared

struct HomeView: View {
    
    @EnvironmentObject private var appState: AppState
    @StateObject private var graduatingViewModel = GraduatingViewModel()
    @StateObject private var mealViewModel = MealViewModel()
    
    var body: some View {
        MyTopAppBar.default(title: "홈") { insets in
            ScrollView {
                VStack(spacing: 10) {
                    if let grade = appState.grade,
                       let school = appState.school {
                        MyCardView(title: "내 정보") {
                            HomeInfoContainer(school: school, grade: grade)
                            .padding(6)
                        }
                    }
                    if let remainTime = graduatingViewModel.remainTime {
                        MyCardView(title: "졸업까지") {
                            HomeGraduatingContainer(
                                remainTime: remainTime,
                                remainTimePercent: graduatingViewModel.remainTimePercent
                            )
                            .padding(6)
                        }
                    }
                    if let meals = mealViewModel.meals {
                        MyCardView(title: "급식") {
                            HomeMealContainer(meals: meals)
                        }
                    }
                }
                .padding(insets)
            }
        }
        .onAppear {
            // 도대체 왜 R.U.S.T.를 쓰지 않는 것인가???????????????????? S.C..O.P.E..... 마렵다 정말
            run {
                guard let grade = appState.grade,
                      let graduating = appState.graduating else {
                    return
                }
                let limit = appState.school?.type?.limit ?? 3
                graduatingViewModel.observe(grade: grade, graduating: graduating, limit: limit)
            }
            run {
                guard let school = appState.school else {
                    return
                }
                mealViewModel.fetchMeals(schoolId: school.id)
            }
        }
    }
}

#Preview {
    HomeView()
        .registerWanted()
}
