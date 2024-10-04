import SwiftUI
import Combine

import Model
import Data
import Shared

import MyDesignSystem
import GoogleSignIn
import MyUIKitExt
import SignKit

struct ProfileView: View {
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var appleObservable = AppleObservable()
    @StateObject private var observable = ProfileObservable()
    
    @State private var isSheetPresent: Bool = false
    
    var body: some View {
        MyTopAppBar.default(
            title: "프로필",
            background: Colors.Background.normal,
            buttons: [
                .init(icon: Icons.Feature.Setting) {
                    router.push(SettingPath())
                }
            ]
        ) { insets in
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    MyAvatar(nil, type: .larger)
                    if let user = appState.currentUser {
                        if let nickname = user.nickname {
                            HStack(spacing: 8) {
                                Text(nickname)
                                    .foreground(Colors.Label.alternative)
                                    .myFont(.bodyR)
                                Button {
                                    router.push(EditProfilePath())
                                } label: {
                                    Image(icon: Icons.Feature.Pen)
                                        .resizable()
                                        .renderingMode(.template)
                                        .foreground(Colors.Label.assistive)
                                        .frame(size: 18)
                                }
                            }
                        } else {
                            Button {
                                router.push(EditProfilePath())
                            } label: {
                                Text("닉네임 설정")
                                    .foreground(Colors.Label.alternative)
                                    .myFont(.bodyR)
                            }
                        }
                    } else {
                        Button {
                            isSheetPresent = true
                        } label: {
                            Text("로그인 하기")
                                .foreground(Colors.Label.alternative)
                                .myFont(.bodyR)
                        }
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
            }
            .padding(insets)
        }
        .sheet(isPresented: $isSheetPresent, content: sheetContent)
        .onReceive(observable.$signInFlow, perform: receiveSubject)
    }
}

// MARK: - Method
extension ProfileView {
    func receiveSubject(flow: Flow) {
        isSheetPresent = false
        switch flow {
        case .success:
            router.replace([MainPath()])
            appState.fetchCurrentUser()
        case .failure:
            dialog.present(
                .init(title: "로그인 실패")
            )
        default:
            break
        }
    }
    
    @ViewBuilder
    func sheetContent() -> some View {
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
