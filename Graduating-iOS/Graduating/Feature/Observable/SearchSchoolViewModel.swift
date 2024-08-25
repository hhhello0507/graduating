//
//  OnboardingViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Combine
import Model
import Data

final class SearchSchoolViewModel: ObservableObject {
    @Published private var schools: [School]?
    @Published public var searchSchoolName = ""

    var subscriptions = Set<AnyCancellable>()
    
    func fetchSchools() {
        SchoolService.shared.getSchools()
            .sink { result in
                print(result)
            } receiveValue: { response in
                self.schools = response
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
}

extension SearchSchoolViewModel {
    public var searchedSchools: [School]? {
        guard let schools, !searchSchoolName.isEmpty else {
            return schools
        }
        return schools.filter { $0.name.contains(searchSchoolName) }
    }
}
