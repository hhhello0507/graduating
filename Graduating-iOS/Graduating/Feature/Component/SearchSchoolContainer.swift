import SwiftUI

import Model

import MyDesignSystem

public struct SearchSchoolContainer {
    @EnvironmentObject private var dialogProvider: DialogProvider
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    
    @FocusState private var field: Bool
    @Binding private var searchText: String
    
    private let schools: [School]?
    private let selectAction: () -> Void
    
    public init(
        for schools: [School]?,
        searchText: Binding<String>,
        selectAction: @escaping () -> Void
    ) {
        self.schools = schools
        self._searchText = searchText
        self.selectAction = selectAction
    }
}

extension SearchSchoolContainer: View {
    public var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 2) {
                MyTextField("학교 검색", text: $searchText)
                    .focused($field)
                Image(icon: Icons.ETC.Search)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .foreground(Colors.Label.alternative)
                    .opacity(0.5)
            }
            .padding(.top, 15)
            if let schools {
                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(schools, id: \.id) { school in
                            SchoolCell(school: school) {
                                dialogProvider.present(
                                    .init(title: "\(school.name) 학생이 맞으신가요?")
                                    .primaryButton("네, 맞아요") {
//                                        appState.school = school
//                                        appState.fetchGraduating(id: school.id)
//                                        selectAction()
                                    }.secondaryButton("닫기")
                                )
                            }
                        }
                    }
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
