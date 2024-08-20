import SwiftUI
import MyDesignSystem

struct OnboardingFirstView: View {
    
    @FocusState private var field: Bool
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: OnboardingViewModel
    
    var body: some View {
        MyTopAppBar.default(title: "학교를 알려주세요 🤔") {
            VStack(spacing: 12) {
                HStack(spacing: 2) {
                    MyTextField("학교 검색", text: $viewModel.schoolName)
                        .focused($field)
                    Image(icon: Icons.ETC.Search)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28)
                        .foreground(Colors.Label.alternative)
                        .opacity(0.5)
                }
                .padding(.top, 15)
                if let schools = viewModel.searchedSchools {
                    ScrollView {
                        LazyVStack(spacing: 4) {
                            ForEach(schools, id: \.id) { school in
                                SchoolCell(school: school) {
                                    router.push(OnboardingDestination.onboardingSecond)
                                }
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Colors.Background.neutral)
            .padding(.horizontal, 15)
        }
        .onAppear {
            viewModel.fetchSchools()
        }
    }
}

#Preview {
    OnboardingFirstView()
        .registerWanted()
}
