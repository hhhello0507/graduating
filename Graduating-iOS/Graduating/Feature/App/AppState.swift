//
//  AppState.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import Foundation

final class AppState: ObservableObject {
    @Published var grade: Int? = UserDefaultsType.grade.value as? Int {
        didSet {
            UserDefaultsType.grade.set(grade)
        }
    }
    @Published var schoolName: String? = UserDefaultsType.schoolName.value as? String {
        didSet {
            UserDefaultsType.schoolName.set(schoolName)
        }
    }
}
