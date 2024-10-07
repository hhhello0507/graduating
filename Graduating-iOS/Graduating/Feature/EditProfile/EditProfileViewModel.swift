import Combine
import Foundation

import Data
import Shared

final class EditProfileViewModel: ObservableObject {
    @Published var editProfileFlow = Flow.idle
    var originNickname: String?
    @Published var nickname = ""
    var subscriptions = Set<AnyCancellable>()
    
    var isValidInput: Bool {
        !nickname.isEmpty && originNickname != nickname
    }
}

extension EditProfileViewModel {
    func initNickname(_ nickname: String) {
        self.originNickname = nickname
        self.nickname = nickname
    }
    
    func editProfile() {
        UserService.shared.editUser(
            .init(nickname: nickname)
        )
        .flow(\.editProfileFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
