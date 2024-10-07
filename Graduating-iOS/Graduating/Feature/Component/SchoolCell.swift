import SwiftUI
import Shared
import MyDesignSystem

struct SchoolCell {
    let school: School
    let action: () -> Void
}

extension SchoolCell: View {
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                HStack(spacing: 4) {
                    Text(school.name)
                        .myFont(.bodyM)
                        .foreground(Colors.Label.normal)
                        .lineLimit(1)
                    Text(school.address.split(separator: " ").prefix(2).joined(separator: " "))
                        .myFont(.labelM)
                        .foreground(Colors.Label.alternative)
                }
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
