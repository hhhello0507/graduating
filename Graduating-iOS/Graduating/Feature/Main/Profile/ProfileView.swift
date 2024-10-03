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
                    VStack(spacing: 4) {
                        MyAvatar(nil, type: .larger)
                            .padding(.vertical, 16)
                        Text("이름")
                            .foreground(Colors.Label.alternative)
                            .myFont(.bodyR)
                    }
                    HStack(spacing: 12) {
                        MyButton("학교 수정", role: .assistive) {
                            router.push(EditSchoolPath())
                        }.size(.medium)
                            .frame(maxWidth: .infinity)
                        MyButton("학년 수정", role: .assistive) {
                            router.push(EditGradePath())
                        }.size(.medium)
                            .frame(maxWidth: .infinity)
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
