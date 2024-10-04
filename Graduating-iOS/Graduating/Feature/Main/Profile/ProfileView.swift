import SwiftUI
import MyDesignSystem
import GoogleSignIn
import MyUIKitExt
import Model
import Data

struct ProfileView: View {
    
    @StateObject private var appleObservable = AppleObservable()
    @StateObject private var observable = ProfileObservable()
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @Environment(\.openURL) private var openURL
    @State private var isSheetPresent: Bool = false
    @AppStorage("accessToken") private var accessToken: String?
    
    var body: some View {
        MyTopAppBar.default(
            title: "프로필",
            background: Colors.Background.normal
        ) { insets in
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    MyAvatar(nil, type: .larger)
                    if accessToken == nil {
                        Button {
                            isSheetPresent = true
                        } label: {
                            Text("로그인 하기")
                                .foreground(Colors.Label.alternative)
                                .myFont(.bodyR)
                        }
                    } else {
                        Text("-")
                            .foreground(Colors.Label.alternative)
                            .myFont(.bodyR)
                    }
                }
                .padding(.top, 16)
                HStack(spacing: 12) {
                    MyButton("학교 수정", role: .assistive, expanded: true) {
                        router.push(EditSchoolPath())
                    }
                    .size(.medium)
                    .frame(maxWidth: .infinity)
                    MyButton("학년 수정", role: .assistive, expanded: true) {
                        router.push(EditGradePath())
                    }
                    .size(.medium)
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 24)
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
                .padding(.bottom, 92)
            }
            .padding(insets)
        }
        .sheet(isPresented: $isSheetPresent) {
            VStack(spacing: 10) {
                AppleSignInButton {
                    appleObservable.signIn { code in
                        observable.signIn(code: code, platformType: .apple)
                    } failureCompletion: {
                        dialog.present(
                            .init(title: "로그인 실패")
                        )
                    }
                }
                GoogleSignInButton {
                    guard let rootViewController = UIApplicationUtil.window?.rootViewController else { return }
                    Task {
                        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                        guard let code = result.serverAuthCode else { return }
                        
                    }
                }
            }
            .padding(20)
            .background(Colors.Background.normal)
            .adjustedHeightSheet()
        }
    }
}
