import Combine
import Foundation

import Data
import Shared

final class EditProfileViewModel: BaseViewModel {
    @Published var editProfileFlow = Flow.idle
    @Published var nickname = ""
}

extension EditProfileViewModel {
    func editProfile() {
        UserService.shared.editUser(
            .init(nickname: nickname)
        )
        .flow(\.editProfileFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
