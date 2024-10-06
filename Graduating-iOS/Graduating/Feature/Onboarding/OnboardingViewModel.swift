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
    @Published var signInFlow = Flow.idle
    
    var subscriptions = Set<AnyCancellable>()
    
    var isValidInput: Bool {
        !nickname.isEmpty
    }
}

extension OnboardingViewModel {
    func signIn() {
        guard let platformType, let code, let school, isValidInput else {
            return
        }
        AuthService.shared.signIn(
            .init(
                platformType: platformType,
                code: code,
                nickname: nickname,
                graduatingYear: graduatingYear,
                schoolId: school.id
            )
        )
        .flow(\.signInFlow, on: self)
        .ignoreError()
        .sink {
            Sign.me.login(id: "", password: "", accessToken: $0.accessToken, refreshToken: $0.refreshToken)
        }
        .store(in: &subscriptions)
    }
}
