//
//  EditProfileObservable.swift
//  Graduating
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation
import Combine

import Data
import Shared

final class EditProfileObservable: BaseViewModel {
    @Published var editProfileFlow = Flow.idle
    @Published var nickname = ""
    
    func editProfile() {
        UserService.shared.editUser(
            .init(nickname: nickname)
        )
        .flow(\.editProfileFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
