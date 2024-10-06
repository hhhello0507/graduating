import SwiftUI

import MyDesignSystem

struct OnboardingFourthView {
    struct Path: Hashable {}
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var dialogProvider: DialogProvider
    @EnvironmentObject private var viewModel: OnboardingViewModel
    
    private let path: Path
    
    public init(path: Path) {
        self.path = path
    }
}

extension OnboardingFourthView: View {
    var body: some View {
        MyTopAppBar.small(title: "") { insets in
            // TODO: 디자인 시스템에 이거 추가 ㄱㄱ
            VStack(spacing: 4) {
                Text("닉네임을 알려주세요")
                    .myFont(.title1B)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                MyTextField("닉네임 입력", text: $viewModel.nickname)
                Spacer()
                MyButton("가입하기", isEnabled: viewModel.isValidInput, expanded: true, action: handleSubmit)
                    .padding(.bottom, 10)
            }
            .padding(insets)
        }
    }
}

extension OnboardingFourthView {
    func handleSubmit() {
        viewModel.signIn()
    }
}
