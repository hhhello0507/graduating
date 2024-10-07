import SwiftUI
import MyDesignSystem

struct EditGraduatingYearView: View {
    struct Path: Hashable {}
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var dialog: DialogProvider
    @EnvironmentObject private var appState: AppState
    
    @StateObject private var viewModel = EditGraduatingYearViewModel()
    
    private let path: Path
    private let currentYear = Date.now[.year]!
    
    public init(path: Path) {
        self.path = path
    }
}

extension EditGraduatingYearView {
    var body: some View {
        MyTopAppBar.small(title: "") { insets in
            VStack(spacing: 4) {
                Text("졸업년도를 알려주세요")
                    .myFont(.title1B)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let limit = appState.currentUser.data?.school.type?.limit {
                    Picker("Graduating Year", selection: $viewModel.graduatingYear) {
                        ForEach((currentYear + 1)...(currentYear + limit), id: \.self) { number in
                            Text(String(number))
                                .myFont(.headling2M)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                Spacer()
                MyButton("다음", expanded: true, action: handleSubmit)
                    .padding(.bottom, 10)
            }
            .padding(insets)
        }
        .onReceive(viewModel.$editGraduatingYearFlow) { flow in
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


extension EditGraduatingYearView {
    func handleSubmit() {
        viewModel.editGraduatingYear()
    }
}
