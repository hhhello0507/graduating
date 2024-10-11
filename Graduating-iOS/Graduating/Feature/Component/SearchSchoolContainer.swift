import SwiftUI
import Shared
import MyDesignSystem

public struct SearchSchoolContainer {
    @Binding private var searchText: String
    @FocusState private var focused
    
    private let schools: Resource<[School]>
    private let selectAction: (School) -> Void
    
    public init(
        for schools: Resource<[School]>,
        searchText: Binding<String>,
        selectAction: @escaping (School) -> Void
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
                    .focused($focused)
                Image(icon: Icons.ETC.Search)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .foreground(Colors.Label.alternative)
                    .opacity(0.5)
            }
            .padding(.top, 15)
            schools.makeView {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } success: { schools in
                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(schools, id: \.id) { school in
                            SchoolCell(school: school) {
                                selectAction(school)
                            }
                        }
                    }
                }
            } failure: { _ in
                Text("에러") // TODO: Handle this for ux
            }
        }
        .onAppear {
            focused = true
        }
    }
}
