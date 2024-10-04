//
//  EditProfileObservable.swift
//  Graduating
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation
import Combine

import Data

final class EditProfileObservable: BaseViewModel {
    enum Subject {
        case editProfileFailure
        case editProfileSuccess
    }
    @Published var nickname = ""
    let subject = PassthroughSubject<Subject, Never>()
    func editProfile() {
        UserService.shared.editUser(
            .init(nickname: nickname)
        ).sink {
            if case .failure = $0 {
                self.subject.send(.editProfileFailure)
            }
        } receiveValue: { _ in
            self.subject.send(.editProfileSuccess)
        }.store(in: &subscriptions)
    }
}
