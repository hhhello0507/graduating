//
//  ProfileViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 10/4/24.
//

import Combine
import Model
import Data
import Foundation
import SignKit

final class ProfileObservable: ObservableObject {
    enum Subject {
        case signInFailure
    }
    var subscription = Set<AnyCancellable>()
    var subject = PassthroughSubject<Subject, Never>()
    func signIn(code: String, platformType: PlatformType) {
        AuthService.shared.oauth2SignIn(
            .init(platformType: platformType, code: code)
        )
        .sink {
            print($0)
        } receiveValue: {
            Sign.me.login(id: "", password: "", accessToken: $0.accessToken, refreshToken: $0.refreshToken)
        }
        .store(in: &subscription)
    }
    
    deinit {
        subscription.forEach {
            $0.cancel()
        }
    }
}
