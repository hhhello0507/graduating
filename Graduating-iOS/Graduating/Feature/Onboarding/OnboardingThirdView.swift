import SwiftUI

import MyDesignSystem

struct OnboardingThirdView {
    struct Path: Hashable {}
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: OnboardingViewModel
    
    private let path: Path
    
    public init(path: Path) {
        self.path = path
    }
}

extension OnboardingThirdView: View {
    var body: some View {
        MyTopAppBar.small(title: "") { insets in
            VStack(spacing: 4) {
                Text("졸업년도를 알려주세요")
                    .myFont(.title1B)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Picker("Graduating Year", selection: $viewModel.graduatingYear) {
                    ForEach(1900...2100, id: \.self) { number in
                        Text(String(number))
                            .myFont(.headling2M)
                    }
                }
                .pickerStyle(.wheel)
                Spacer()
                MyButton("다음", expanded: true, action: handleSubmit)
                    .padding(.bottom, 10)
            }
            .padding(insets)
        }
    }
}

extension OnboardingThirdView {
    func handleSubmit() {
        router.push(OnboardingFourthView.Path())
    }
}
