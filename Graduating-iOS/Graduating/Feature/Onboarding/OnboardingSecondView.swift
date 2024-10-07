import SwiftUI
import MyDesignSystem

struct OnboardingSecondView {
    struct Path: Hashable {}
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: OnboardingViewModel
    
    @StateObject private var searchSchoolViewModel = SearchSchoolViewModel()
    
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
                for: searchSchoolViewModel.searchedSchools,
                searchText: $searchSchoolViewModel.searchSchoolName
            ) { school in
                viewModel.school = school
                router.push(OnboardingThirdView.Path())
            }
            .padding(insets)
        }
    }
}

#Preview {
    OnboardingSecondView(path: .init())
        .registerWanted()
}
