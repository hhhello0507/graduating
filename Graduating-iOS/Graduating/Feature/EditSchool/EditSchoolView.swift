import SwiftUI
import MyDesignSystem

struct EditSchoolView: View {
    struct Path: Hashable {}
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var searchSchoolViewModel = SearchSchoolViewModel()
    @StateObject private var viewModel = EditSchoolViewModel()
    
    private let path: Path
    
    init(path: Path) {
        self.path = path
    }
}

extension EditSchoolView {
    var body: some View {
        MyTopAppBar.small(title: "") { insets in
            VStack(spacing: 12) {
                Text("학교를 알려주세요 🤔")
                    .myFont(.title1B)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                SearchSchoolContainer(
                    for: searchSchoolViewModel.searchedSchools,
                    searchText: $searchSchoolViewModel.searchSchoolName
                ) { school in
                    viewModel.editSchool(schoolId: school.id)
                }
            }
            .padding(insets)
        }
        .onReceive(viewModel.$editSchoolFlow) { flow in
            switch flow {
            case .success:
                appState.fetchCurrentUser()
                router.toRoot()
            case .failure:
                dialog.present(
                    .init(title: "수정 실패")
                    .message("잠시 후 다시 시도해 주세요")
                )
            default:
                break
            }
        }
    }
}
