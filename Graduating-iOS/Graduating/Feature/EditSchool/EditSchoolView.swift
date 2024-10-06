import SwiftUI

import MyDesignSystem

struct EditSchoolPath: Hashable {}

struct EditSchoolView: View {
    @EnvironmentObject private var router: Router
    
    @StateObject private var viewModel = SearchSchoolViewModel()
    
    init(_ path: EditSchoolPath) {}
}

extension EditSchoolView {
    var body: some View {
        MyTopAppBar.small(title: "") { insets in
            VStack(spacing: 12) {
                Text("학교를 알려주세요 🤔")
                    .myFont(.title1B)
                    .foreground(Colors.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                SearchSchoolContainer(for: viewModel.searchedSchools, searchText: $viewModel.searchSchoolName) { _ in
                    router.toRoot()
                }
            }
            .padding(insets)
        }
        .onAppear {
            viewModel.fetchSchools()
        }
    }
}
