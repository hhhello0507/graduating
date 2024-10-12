//  Author: hhhello0507
//  Created: 10/11/24

import Combine
import Foundation
import Shared
import Data

final class ScholarshipViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Published var scholarships: Resource<[Scholarship]> = .idle
    
    var isFirstOnAppear: Bool = true
}

extension ScholarshipViewModel: OnAppearProtocol {
    func fetchAllData() {
        fetchScholarships()
    }
}

extension ScholarshipViewModel {
    func refresh() {
        fetchAllData()
    }
    
    func fetchScholarships() {
        ScholarshipService.shared.getScholarships()
            .map {
                $0.sorted {
                    if let endDate1 = $0.recruitmentEndDate, let endDate2 = $1.recruitmentEndDate {
                        return endDate1 < endDate2
                    } else if $0.recruitmentEndDate == nil {
                        return true
                    } else {
                        return false
                    }
                }
            }
            .resource(\.scholarships, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
