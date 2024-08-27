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
                    MyCardView(title: "내 정보") {
                        VStack(spacing: 4) {
                            HStack(spacing: 8) {
                                Text("학교")
                                    .myFont(.bodyB)
                                    .foreground(Colors.Label.assistive)
                                if let school = appState.school {
                                    Text(school.name)
                                        .myFont(.bodyM)
                                        .foreground(Colors.Label.alternative)
                                }
                                Spacer()
                            }
                            HStack(spacing: 8) {
                                Text("학년")
                                    .myFont(.bodyB)
                                    .foreground(Colors.Label.assistive)
                                if let grade = appState.grade {
                                    Text("\(grade)학년")
                                        .myFont(.bodyM)
                                        .foreground(Colors.Label.alternative)
                                }
                                Spacer()
                            }
                        }
                        .padding(6)
                    }
                    MyCardView(title: "졸업까지") {
                        HStack {
                            if let remainTime = graduatingViewModel.remainTime {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(String(format: "%.7f%%", graduatingViewModel.remainTimePercent * 100))
                                        .myFont(.headlineM)
                                        .foreground(Colors.Label.strong)
                                    Text(remainTime.🎓)
                                    .myFont(.labelR)
                                    .foreground(Colors.Label.alternative)
                                }
                            }
                            Spacer()
                            MyCircularProgressView(progress: graduatingViewModel.remainTimePercent)
                        }
                        .padding(6)
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
