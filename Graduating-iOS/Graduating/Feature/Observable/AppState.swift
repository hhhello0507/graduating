//
//  AppState.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Combine
import Foundation

final class AppState: ObservableObject {
    
    enum Subject {
        case fetchedGraduating(Graduating)
    }
    
    @Published var grade: Int? = UserDefaultsType.grade.value as? Int {
        didSet {
            UserDefaultsType.grade.set(grade)
        }
    }
    // json
    @Published var school: School? = {
        guard let json = UserDefaultsType.school.value as? String else {
            return nil
        }
        return School.decode(json)
    }() {
        didSet {
            let json = school?.encoded()
            UserDefaultsType.school.set(json)
        }
    }
    @Published var graduating: Graduating? = {
        guard let json = UserDefaultsType.graduating.value as? String else {
            return nil
        }
        return Graduating.decode(json)
    }() {
        didSet {
            let json = graduating?.encoded()
            UserDefaultsType.graduating.set(json)
        }
    }
    var subject = PassthroughSubject<Subject, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    func fetchGraduating(id: Int) {
        SchoolService.shared.getGraduating(id: id)
            .sink { result in
                switch result {
                case .failure:
                    self.graduating = nil
                    break
                default:
                    break
                }
            } receiveValue: { response in
                self.subject.send(.fetchedGraduating(response))
                self.graduating = response
            }
            .store(in: &subscriptions)
    }
}
