//  Author: hhhello0507
//  Created: 10/6/24


import SwiftUI
import MyDesignSystem
import MyUIKitExt
import GoogleSignIn
import Shared

struct OnboardingFirstView {
    @Environment(\.openURL) private var openURL
    
    @EnvironmentObject private var viewModel: OnboardingViewModel
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var oauth2ViewModel = OAuth2ViewModel()
    
    init() {}
}

extension OnboardingFirstView: View {
    var body: some View {
        MyTopAppBar.default(title: "") { insets in
            VStack(spacing: 8) {
                Spacer()
                Image(.appIconLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 92)
                Text("졸업이당")
                    .foreground(Colors.Label.normal)
                    .myFont(.bodyM)
                AppleSignInButton {
                    oauth2ViewModel.appleSignIn()
                }
                .disabled(oauth2ViewModel.isFetching)
                .padding(.top, 32)
                GoogleSignInButton {
                    oauth2ViewModel.googleSignIn()
                }
                .disabled(oauth2ViewModel.isFetching)
                Spacer()
                Button {
                    openURL.callAsFunction(
                        URL(string: "https://github.com/hhhello0507/graduating/blob/main/privacy_policy.md")!
                    )
                } label: {
                    Text("개인정보 처리 방침")
                        .myFont(.labelR)
                        .foreground(Colors.Label.alternative)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
        }
        .onReceive(oauth2ViewModel.$appleSignInFlow) {
            receiveSignInFlow($0, platformType: .apple)
        }
        .onReceive(oauth2ViewModel.$googleSignInFlow) {
            receiveSignInFlow($0, platformType: .google)
        }
        .onReceive(viewModel.$signInFlow) {
            if case .success(let token) = $0 {
                appState.signIn(token: token)
                if case .pending = token.state {
                    router.push(OnboardingSecondView.Path())
                }
            }
        }
    }
}

extension OnboardingFirstView {
    func receiveSignInFlow(_ flow: Resource<String>, platformType: PlatformType) {
        switch flow {
        case .success(let code):
            viewModel.code = code
            viewModel.platformType = platformType
            viewModel.signIn()
            
        case .failure:
            dialog.present(
                .init(title: "로그인 실패")
                .message("잠시 후 다시 시도해 주세요")
            )
        default:
            break
        }
    }
}
