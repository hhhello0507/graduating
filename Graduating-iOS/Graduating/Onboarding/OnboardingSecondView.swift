import SwiftUI
import MyDesignSystem

struct OnboardingSecondView: View {
    
    @State private var grade = ""
    @FocusState private var field
    @EnvironmentObject private var router: Router

    var body: some View {
        MyTopAppBar.default(title: "학년을 알려주세요") {
            VStack(spacing: 12) {
                MyTextField("학교 이름", text: $grade)
                    .focused($field)
                    .padding(.top, 15)
                Spacer()
                MyButton("다음") {
                    
                }
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    OnboardingSecondView()
}
