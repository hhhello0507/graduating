//
//  HomeInfoContainer.swift
//  Graduating
//
//  Created by hhhello0507 on 8/28/24.
//

import SwiftUI
import Model
import MyDesignSystem

public struct HomeInfoContainer: View {
    
    private let school: School
    private let grade: Int
    
    init(school: School, grade: Int) {
        self.school = school
        self.grade = grade
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                Text("학교")
                    .myFont(.bodyB)
                    .foreground(Colors.Label.assistive)
                Text(school.name)
                    .myFont(.bodyM)
                    .foreground(Colors.Label.alternative)
                Spacer()
            }
            HStack(spacing: 8) {
                Text("학년")
                    .myFont(.bodyB)
                    .foreground(Colors.Label.assistive)
                Text("\(grade)학년")
                    .myFont(.bodyM)
                    .foreground(Colors.Label.alternative)
                Spacer()
            }
        }
    }
}
