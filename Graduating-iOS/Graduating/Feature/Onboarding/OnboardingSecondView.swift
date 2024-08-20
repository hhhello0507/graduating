import SwiftUI
import MyDesignSystem

struct OnboardingSecondView: View {
    
    @FocusState private var field
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: OnboardingViewModel
    @EnvironmentObject private var dialogProvider: DialogProvider
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        MyTopAppBar.small(title: "") {
            VStack(spacing: 4) {
                Text("학년을 알려주세요")
                    .myFont(.title1B)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker("Grade", selection: $viewModel.grade) {
                    ForEach(1...3, id: \.self) { number in
                        Text("\(number)")
                            .myFont(.headling2M)
                    }
                }
                .pickerStyle(.wheel)
                Spacer()
                MyButton("다음") {
                    dialogProvider.present(
                        .init(title: "\(viewModel.schoolName) \(viewModel.grade)학년이 맞으신가요?")
                        .primaryButton("네, 맞아요") {
                            appState.grade = viewModel.grade
                            appState.schoolName = viewModel.schoolName
                            router.toRoot()
                        }
                        .secondaryButton("닫기")
                    )
                }
                .padding(.bottom, 10)
            }
            .padding(.top, 15)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    OnboardingSecondView()
}
