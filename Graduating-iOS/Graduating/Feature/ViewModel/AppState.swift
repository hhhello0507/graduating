import Combine
import Foundation

import Data
import Model
import Shared

import SignKit

final class AppState: ObservableObject {
    @Published var currentUser: Resource<User> = .idle
    @Published var userState: UserState = .pending
    var shouldSignUp: Bool {
        userState == .pending
    }
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchCurrentUser()
    }
}

extension AppState {
    func logout() {
        Sign.me.logout()
        userState = .pending
        currentUser = .idle
    }
    
    func signIn(token: Token) {
        Sign.me.login(id: "", password: "", accessToken: token.accessToken, refreshToken: token.refreshToken)
        fetchCurrentUser()
        self.userState = token.state
    }
    
    private func fetchCurrentUser() {
        guard case .idle  = currentUser else { return }
        UserService.shared.getMe()
            .resource(\.currentUser, on: self)
            .sink {
                if case .failure(let error) = $0,
                   case .refreshFailure = error {
                    self.logout()
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
    }
}
