import SwiftUI

import MyDesignSystem
import SignKit

struct SettingPath: Hashable {}

struct SettingView {
    @Environment(\.openURL) private var openURL
    
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
}

extension SettingView: View {
    var body: some View {
        MyTopAppBar.small(
            title: "설정",
            background: Colors.Background.normal
        ) { insets in
            VStack(spacing: 12) {
                MyRowView("로그아웃") {
                    dialog.present(
                        .init(title: "로그아웃 하시겠습니까?")
                        .primaryButton("로그아웃") {
                            router.replace([MainPath()])
                            appState.logout()
                        }.secondaryButton("취소")
                    )
                }
                Spacer()
                Button {
                    openURL.callAsFunction(
                        URL(string: "https://github.com/hhhello0507/graduating/blob/main/privacy_policy.md")!
                    )
                } label: {
                    Text("개인정보 처리 방침")
                        .myFont(.labelR)
                        .foreground(Colors.Label.alternative)
                        .opacity(0.5)
                }
                .padding(.bottom, 24)
            }
            .padding(.top, 16)
        }
    }
}
