import Combine
import Foundation

import Data
import Model
import Shared

import SignKit

final class AppState: ObservableObject {
    @Published var currentUser: Resource<User> = .idle
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchCurrentUser()
    }
    
    func logout() {
        Sign.me.logout()
        currentUser = .idle
    }
}

extension AppState {
    func fetchCurrentUser() {
        UserService.shared.getMe()
            .resource(\.currentUser, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
