//  Author: hhhello0507
//  Created: 10/6/24


import Foundation
import Combine
import Shared
import Model
import Data
import SignKit

final class OnboardingViewModel: ObservableObject {
    @Published var code: String?
    @Published var platformType: PlatformType?
    @Published var school: School?
    @Published var graduatingYear = Date.now[.year] ?? 1900
    @Published var nickname: String = ""
    @Published var signUpFlow: Resource<Token> = .idle
    @Published var signInFlow: Resource<Token> = .idle
    
    var subscriptions = Set<AnyCancellable>()
    
    var isValidInput: Bool {
        !nickname.isEmpty
    }
}

extension OnboardingViewModel {
    func signUp() {
        guard let platformType, let code, let school, isValidInput else {
            return
        }
        AuthService.shared.signUp(
            .init(
                platformType: platformType,
                code: code,
                nickname: nickname,
                graduatingYear: graduatingYear,
                schoolId: school.id
            )
        )
        .resource(\.signInFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func signIn() {
        guard let platformType, let code else {
            return
        }
        AuthService.shared.signIn(
            .init(platformType: platformType, code: code)
        )
        .resource(\.signUpFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
