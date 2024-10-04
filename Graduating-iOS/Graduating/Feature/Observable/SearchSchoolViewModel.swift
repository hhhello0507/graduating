//
//  OnboardingViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Combine
import Model
import Data

final class SearchSchoolViewModel: BaseViewModel {
    @Published private var schools: [School]?
    @Published public var searchSchoolName = ""
    public var searchedSchools: [School]? {
        guard let schools, !searchSchoolName.isEmpty else {
            return schools
        }
        return schools.filter { $0.name.contains(searchSchoolName) }
    }
    
    func fetchSchools() {
        SchoolService.shared.getSchools()
            .ignoreError()
            .assign(to: \.schools, on: self)
            .store(in: &subscriptions)
    }
}
