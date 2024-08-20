import SwiftUI
import MyDesignSystem

struct OnboardingFirstView: View {
    
    @State private var schoolName = ""
    @FocusState private var field: Bool
    @EnvironmentObject private var router: Router
    
    var body: some View {
        MyTopAppBar.default(title: "학교를 알려주세요") {
            VStack(spacing: 12) {
                MyTextField("학교 이름", text: $schoolName)
                    .focused($field)
                    .padding(.top, 15)
                Spacer()
                MyButton("다음") {
                    router.push(OnboardingDestination.onboardingSecond)
                }
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    OnboardingFirstView()
        .registerWanted()
}
