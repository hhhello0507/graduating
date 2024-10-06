//  Author: hhhello0507
//  Created: 10/6/24


import SwiftUI
import MyDesignSystem
import MyUIKitExt
import GoogleSignIn
import Shared
import Model

struct OnboardingFirstView {
    
    @EnvironmentObject private var viewModel: OnboardingViewModel
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var oauth2ViewModel = OAuth2ViewModel()
    
    init() {}
}

extension OnboardingFirstView: View {
    var body: some View {
        MyTopAppBar.default(title: "로그인") { insets in
            VStack(spacing: 8) {
                Text("로그인 뷰 만들어라") // TODO: Just
                Spacer()
                AppleSignInButton {
                    oauth2ViewModel.appleSignIn()
                }
                .disabled(oauth2ViewModel.isFetching)
                GoogleSignInButton {
                    oauth2ViewModel.googleSignIn()
                }
                .disabled(oauth2ViewModel.isFetching)
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
