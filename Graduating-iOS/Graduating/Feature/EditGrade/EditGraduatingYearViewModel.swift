//  Author: hhhello0507
//  Created: 10/7/24

import Combine
import Foundation
import Data
import Shared

final class EditGraduatingYearViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    @Published var graduatingYear = Date.now[.year]!
    @Published var editGraduatingYearFlow = Flow.idle
    
    func editGraduatingYear() {
        UserService.shared.editUser(
            .init(graduatingYear: graduatingYear)
        )
        .flow(\.editGraduatingYearFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
