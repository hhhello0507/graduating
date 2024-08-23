import SwiftUI
import MyDesignSystem

struct ProfileView: View {
    
    @EnvironmentObject private var router: Router
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        MyTopAppBar.default(
            title: "프로필",
            background: Colors.Background.normal
        ) { _ in
            ScrollView {
                LazyVStack(spacing: 12) {
                    MyRowView("학교 수정") {
                        router.push(EditSchoolPath())
                    }
                    MyRowView("학년 수정") {
                        router.push(EditGradePath())
                    }
                    MyDivider()
                        .padding(.horizontal, 20)
                    MyRowView("개인정보 처리 방침") {
                        openURL.callAsFunction(
                            URL(string: "https://github.com/hhhello0507/graduating/blob/main/privacy_policy.md")!)
                    }
                }
                .padding(.top, 10)
            }
            .background(Colors.Background.normal)
        }
    }
}
