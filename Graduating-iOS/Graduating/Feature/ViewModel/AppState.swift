import Combine
import Foundation

import Data
import Model
import Shared

import SignKit

final class AppState: ObservableObject {
    @Published var currentUser: Resource<User> = .idle
    @Published var isLoggedIn: Bool = Sign.me.isLoggedIn
    @Published var userState: UserState = .pending
    var shouldSignUp: Bool {
        !isLoggedIn && userState == .pending
    }
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchCurrentUser()
    }
}

extension AppState {
    func logout() {
        Sign.me.logout()
        currentUser = .idle
        isLoggedIn = Sign.me.isLoggedIn
    }
    
    func signIn(token: Token) {
        Sign.me.login(id: "", password: "", accessToken: token.accessToken, refreshToken: token.refreshToken)
        fetchCurrentUser()
        isLoggedIn = Sign.me.isLoggedIn
        self.userState = token.state
    }
    
    private func fetchCurrentUser() {
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
