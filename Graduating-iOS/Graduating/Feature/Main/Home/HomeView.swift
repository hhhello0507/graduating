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
                        .shadow(.evBlack1)
                        if let graduating = user.graduating {
                            MyCardView(title: "졸업까지") {
                                HomeGraduatingContainer(for: graduating)
                                    .padding(6)
                            }
                            .shadow(.evBlack1)
                        }
                    }
                }
                .padding(insets)
                .padding(.bottom, 80)
            }
            .googleBannderAd(inset: .top, adUnitId: "ca-app-pub-2589637472995872/5071938902")
        }
    }
}

#Preview {
    HomeView()
        .registerWanted()
}
