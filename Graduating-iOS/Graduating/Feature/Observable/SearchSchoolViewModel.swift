import Combine

import Model
import Data

final class SearchSchoolViewModel: BaseViewModel {
    @Published private var schools: [School]?
    @Published public var searchSchoolName = ""
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
            .store(in: &subscriptions)
    }
}
