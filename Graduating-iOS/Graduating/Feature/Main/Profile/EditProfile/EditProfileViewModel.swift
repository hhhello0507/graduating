import Combine
import Foundation

import Data
import Shared

final class EditProfileViewModel: ObservableObject {
    @Published var editProfileFlow = Flow.idle
    @Published var nickname = ""
    let subscriptionManager = SubscriptionManager()
}

extension EditProfileViewModel {
    func editProfile() {
        UserService.shared.editUser(
            .init(nickname: nickname)
        )
        .flow(\.editProfileFlow, on: self)
        .silentSink()
        .store(in: &subscriptionManager.subscriptions)
    }
}
