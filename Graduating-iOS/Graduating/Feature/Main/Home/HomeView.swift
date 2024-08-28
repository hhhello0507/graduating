import SwiftUI
import MyDesignSystem
import Combine
import Shared

struct HomeView: View {
    
    @EnvironmentObject private var appState: AppState
    @StateObject private var graduatingViewModel = GraduatingViewModel()
    
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
                }
                .padding(insets)
            }
        }
        .onAppear {
            guard let grade = appState.grade,
                  let graduating = appState.graduating else {
                return
            }
            let limit = appState.school?.type?.limit ?? 3
            graduatingViewModel.observe(grade: grade, graduating: graduating, limit: limit)
        }
    }
}

#Preview {
    HomeView()
        .registerWanted()
}
