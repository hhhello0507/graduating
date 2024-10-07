import Combine
import Foundation
import Data
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
        userState = UserDefaults.graduating.bool(forKey: "userStateIsPending") ? .pending : .none
        $userState.sink {
            UserDefaults.graduating.set($0 == .pending, forKey: "userStateIsPending")
        }
        .store(in: &subscriptions)
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
    
    func fetchCurrentUser() {
        UserService.shared.getMe()
            .resource(\.currentUser, on: self)
            .sink {
                if case .failure(let error) = $0 {
                    if case .refreshFailure = error {
                        self.logout()
                    }
                    if case .http(let err) = error, err.status == 404 {
                        self.logout()
                    }
                }
            } receiveValue: { _ in }
            .store(in: &subscriptions)
    }
}
