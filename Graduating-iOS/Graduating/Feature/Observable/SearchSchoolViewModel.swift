import Combine

import Model
import Data

final class SearchSchoolViewModel: ObservableObject {
    @Published private var schools: [School]?
    @Published public var searchSchoolName = ""
    
    let subscriptionManager = SubscriptionManager()
}

extension SearchSchoolViewModel {
    public var searchedSchools: [School]? {
        guard let schools, !searchSchoolName.isEmpty else {
            return schools
        }
        return schools.filter { $0.name.contains(searchSchoolName) }
    }
}

extension SearchSchoolViewModel {
    func fetchSchools() {
        SchoolService.shared.getSchools()
            .ignoreError()
            .assign(to: \.schools, on: self)
            .store(in: &subscriptionManager.subscriptions)
    }
}
