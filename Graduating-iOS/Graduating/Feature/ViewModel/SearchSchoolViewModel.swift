import Combine
import Model
import Data
import Shared

final class SearchSchoolViewModel: ObservableObject {
    @Published private var schools: Resource<[School]> = .idle
    @Published public var searchSchoolName = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchSchools()
    }
}

extension SearchSchoolViewModel {
    public var searchedSchools: Resource<[School]> {
        if searchSchoolName.isEmpty {
            self.schools
        } else {
            self.schools.map {
                $0.filter { $0.name.contains(searchSchoolName) }
            }
        }
    }
}

extension SearchSchoolViewModel {
    func fetchSchools() {
        SchoolService.shared.getSchools()
            .resource(\.schools, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
