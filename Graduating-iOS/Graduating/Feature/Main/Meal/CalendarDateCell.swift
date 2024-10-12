import SwiftUI
import Shared
import MyDesignSystem
import ScopeKit

struct CalendarDateCell {
    private let date: Date?
    private let selected: Bool
    
    init(
        date: Date?,
        selected: Bool
    ) {
        self.date = date
        self.selected = selected
    }
    
    private var label: String {
        date?.let { date in
            "\(date[.day])"
        } ?? ""
    }
}

extension CalendarDateCell: View {
    var body: some View {
        Text(label)
            .myFont(.headlineM)
            .foreground(
                selected
                ? Colors.Static.white
                : Colors.Label.alternative
            )
            .padding(.vertical, 8)
            .background {
                if selected {
                    Rectangle()
                        .fill(Colors.Primary.normal)
                        .cornerRadius(12, corners: .allCorners)
                        .frame(width: 36, height: 36)
                }
            }
            .frame(maxWidth: .infinity)
            .opacity(date == nil ? 0 : 1)
    }
}
