//
//  AppState.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Combine
import Foundation
import Model
import Data
import SignKit

final class AppState: BaseViewModel {
    
    enum Subject {
        case fetchedGraduating(Graduating)
    }
    
    var subject = PassthroughSubject<Subject, Never>()
    @Published var grade: Int? = UserDefaultsType.grade.value as? Int {
        didSet {
            UserDefaultsType.grade.set(grade)
        }
    }
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
    @Published var graduatingFetchFailure = false
    @Published var currentUser: User?
    
    private var observer: NSKeyValueObservation?
    override init() {
        super.init()
    }
    
    func fetchGraduating(id: Int) {
        SchoolService.shared.getGraduating(id: id)
            .sink {
                switch $0 {
                case .failure:
                    self.graduating = nil
                    self.graduatingFetchFailure = true
                default: break
                }
            } receiveValue: { res in
                self.subject.send(.fetchedGraduating(res))
                self.graduating = res
            }
            .store(in: &subscriptions)
    }
    
    func fetchCurrentUser() {
        UserService.shared.getMe()
            .ignoreError()
            .assign(to: \.currentUser, on: self)
            .store(in: &subscriptions)
    }
}
