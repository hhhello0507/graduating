//
//  SchoolList.swift
//  Graduating
//
//  Created by hhhello0507 on 8/21/24.
//

import SwiftUI
import MyDesignSystem

public struct SchoolScrollView: View {
    
    @EnvironmentObject private var dialogProvider: DialogProvider
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    
    let schools: [School]
    
    public init(for schools: [School]) {
        self.schools = schools
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(schools, id: \.id) { school in
                    SchoolCell(school: school) {
                        dialogProvider.present(
                            .init(title: "\(school.name) 학생이 맞으신가요?")
                            .primaryButton("네, 맞아요") {
                                appState.school = school
                                appState.fetchGraduating(id: school.id)
                                if appState.grade == nil {
                                    router.push(OnboardingDestination.onboardingSecond)
                                } else {
                                    router.toRoot()
                                }
                            }.secondaryButton("닫기")
                        )
                    }
                }
            }
        }
    }
}
