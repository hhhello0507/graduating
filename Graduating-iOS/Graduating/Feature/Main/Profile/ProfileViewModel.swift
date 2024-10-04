import Combine
import Foundation

import Data
import Model
import Shared

import SignKit

final class ProfileViewModel: BaseViewModel {
    @Published var signInFlow = Flow.idle
}

extension ProfileViewModel {
    func signIn(code: String, platformType: PlatformType) {
        AuthService.shared.oauth2SignIn(
            .init(platformType: platformType, code: code)
        )
        .flow(\.signInFlow, on: self)
        .ignoreError()
        .sink {
            Sign.me.login(id: "", password: "", accessToken: $0.accessToken, refreshToken: $0.refreshToken)
        }
        .store(in: &subscriptions)
    }
}
