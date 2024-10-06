import Combine
import Foundation

import Data
import Model
import Shared

import SignKit

final class AppState: ObservableObject {
    @Published var currentUser: Resource<User> = .idle
    @Published var isLoggedIn: Bool = Sign.me.isLoggedIn
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchCurrentUser()
    }
    
    func logout() {
        Sign.me.logout()
        currentUser = .idle
        isLoggedIn = false
    }
}

extension AppState {
    func fetchCurrentUser() {
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
