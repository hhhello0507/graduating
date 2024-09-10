//
//  HomeGraduatingContainer.swift
//  Graduating
//
//  Created by hhhello0507 on 8/28/24.
//

import SwiftUI
import Model
import MyDesignSystem

public struct HomeGraduatingContainer: View {
    
    private let remainTime: DateComponents
    private let remainTimePercent: Double
    
    init(
        remainTime: DateComponents,
        remainTimePercent: Double
    ) {
        self.remainTime = remainTime
        self.remainTimePercent = remainTimePercent
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(String(format: "%.7f%%", remainTimePercent * 100))
                    .myFont(.headlineM)
                    .foreground(Colors.Label.strong)
                Text(remainTime.🎓)
                    .myFont(.labelR)
                    .foreground(Colors.Label.alternative)
            }
            Spacer()
            MyCircularProgressView(progress: remainTimePercent)
        }
    }
}
