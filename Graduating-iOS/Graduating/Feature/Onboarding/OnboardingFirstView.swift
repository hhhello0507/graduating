import SwiftUI
import MyDesignSystem

struct OnboardingFirstView: View {
    
    @StateObject private var viewModel = SearchSchoolViewModel()
    @EnvironmentObject private var router: Router
    
    var body: some View {
        MyTopAppBar.default(
            title: "학교를 알려주세요 🤔"
        ) { insets in
            SearchSchoolContainer(for: viewModel.searchedSchools, searchText: $viewModel.searchSchoolName) {
                router.push(EditGradePath())
            }
            .padding(insets)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Colors.Background.neutral)
        .onAppear {
            viewModel.fetchSchools()
        }
    }
}

#Preview {
    OnboardingFirstView()
        .registerWanted()
}
