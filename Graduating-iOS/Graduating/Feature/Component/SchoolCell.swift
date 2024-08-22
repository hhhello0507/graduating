//
//  SchoolCell.swift
//  Graduating
//
//  Created by hhhello0507 on 8/20/24.
//

import SwiftUI
import MyDesignSystem

struct SchoolCell: View {
    
    let school: School
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(school.name)
                    .myFont(.bodyM)
                    .foreground(Colors.Label.normal)
                Spacer()
                Image(icon: Icons.Arrow.ExpandArrow)
                    .resizable()
                    .renderingMode(.template)
                    .foreground(Colors.Label.assistive)
                    .frame(width: 14, height: 14)
                    .rotationEffect(.degrees(180))
            }
            .padding(.vertical, 12)
            .background(Colors.Background.neutral)
        }
        .scaledButton()
    }
}
