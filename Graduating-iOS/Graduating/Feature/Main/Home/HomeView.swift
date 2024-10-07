import SwiftUI
import MyDesignSystem
import Combine

import Shared

struct HomeView {
    @EnvironmentObject private var appState: AppState
}

extension HomeView: View {
    var body: some View {
        MyTopAppBar.default(title: "홈") { insets in
            ScrollView {
                VStack(spacing: 10) {
                    if let user = appState.currentUser.data {
                        MyCardView(title: "내 정보") {
                            HomeInfoContainer(for: user)
                                .padding(6)
                        }
                        if let graduating = user.graduating {
                            MyCardView(title: "졸업까지") {
                                HomeGraduatingContainer(for: graduating)
                                    .padding(6)
                            }
                        }
                    }
                }
                .padding(insets)
                .padding(.bottom, 80)
            }
//            .refreshable(action: handleRefresh)
        }
    }
}

// MARK: - Method
extension HomeView {
//    @Sendable
//    func handleRefresh() async {
//        guard let grade = appState.grade,
//              let graduating = appState.graduating else {
//            return
//        }
//        let limit = appState.school?.type?.limit ?? 3
//        graduatingViewModel.observe(grade: grade, graduating: graduating, limit: limit)
//    }
}

#Preview {
    HomeView()
        .registerWanted()
}
