import SwiftUI
import MyDesignSystem

struct MealMenuText: View {
    
    let text: String
    let isMealEmpty: Bool
    
    init(text: String, isMealEmpty: Bool = false) {
        self.text = text
        self.isMealEmpty = isMealEmpty
    }
    
    var body: some View {
        VStack {
            if isMealEmpty {
                Text(text)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                Text(text)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.caption)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    MealMenuText(text: "test", isMealEmpty: true)
}
