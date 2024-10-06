import SwiftUI
import MyDesignSystem

struct OnboardingSecondView {
    struct Path: Hashable {}
    
    @EnvironmentObject private var router: Router
    
    @StateObject private var viewModel = SearchSchoolViewModel()
    
    private let path: Path
    
    init(path: Path) {
        self.path = path
    }
}

extension OnboardingSecondView: View {
    var body: some View {
        MyTopAppBar.default(
            title: "학교를 알려주세요 🤔"
        ) { insets in
            SearchSchoolContainer(
                for: viewModel.searchedSchools,
                searchText: $viewModel.searchSchoolName
            ) {
                router.push(OnboardingThirdView.Path())
            }
            .padding(insets)
        }
        .background(Colors.Background.neutral)
    }
}

#Preview {
    OnboardingSecondView(path: .init())
        .registerWanted()
}
