//
//  OnboardingViewModel.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Combine

final class OnboardingViewModel: ObservableObject {
    @Published var schools: [School]?
    @Published var schoolName = ""
    @Published var grade = 1
    var searchedSchools: [School]? {
        guard let schools else {
            return nil
        }
        guard !schoolName.isEmpty else {
            return schools
        }
        return schools.filter { $0.name.contains(schoolName) }
    }

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
