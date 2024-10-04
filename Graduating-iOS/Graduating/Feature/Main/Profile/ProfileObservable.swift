//
//  ProfileViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 10/4/24.
//

import Combine
import Foundation

import Model
import Data
import Shared

import SignKit

final class ProfileObservable: BaseViewModel {
    
    @Published var signInFlow = Flow.idle
    
    func signIn(code: String, platformType: PlatformType) {
        AuthService.shared.oauth2SignIn(
            .init(platformType: platformType, code: code)
        )
        .flow(\.signInFlow, on: self)
        .ignoreError()
        .sink {
            Sign.me.login(id: "", password: "", accessToken: $0.accessToken, refreshToken: $0.refreshToken)
        }
        .store(in: &subscriptions)
    }
}
