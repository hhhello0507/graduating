import Combine
import Foundation

import Data
import Shared

final class EditProfileViewModel: ObservableObject {
    @Published var editProfileFlow = Flow.idle
    @Published var nickname = ""
    var subscriptions = Set<AnyCancellable>()
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
