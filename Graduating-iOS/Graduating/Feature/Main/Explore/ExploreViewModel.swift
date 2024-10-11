//  Author: hhhello0507
//  Created: 10/11/24

import Combine
import Foundation
import Shared
import Data

final class ExploreViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Published var scholarships: Resource<[Scholarship]> = .idle
    
    var isFirstOnAppear: Bool = true
}

extension ExploreViewModel: OnAppearProtocol {
    func fetchAllData() {
        fetchScholarships()
    }
}

extension ExploreViewModel {
    func refresh() {
        fetchAllData()
    }
    
    func fetchScholarships() {
        ScholarshipService.shared.getScholarships()
            .resource(\.scholarships, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
