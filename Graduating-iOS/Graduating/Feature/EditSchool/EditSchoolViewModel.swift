//  Author: hhhello0507
//  Created: 10/7/24


import Foundation
import Data
import Model
import Combine
import Shared

final class EditSchoolViewModel: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var editSchoolFlow = Flow.idle
}

extension EditSchoolViewModel {
    func editSchool(schoolId: Int) {
        UserService.shared.editUser(
            .init(schoolId: schoolId)
        )
        .flow(\.editSchoolFlow, on: self)
        .silentSink()
        .store(in: &subscription)
    }
}
