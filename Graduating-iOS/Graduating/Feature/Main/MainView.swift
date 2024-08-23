import SwiftUI
import MyDesignSystem

enum Item: BottomAppBarItem {
    
    case home
    case profile
    
    var icon: Iconable {
        switch self {
        case .home: Icons.Feature.Home
        case .profile: Icons.Feature.Person
        }
    }
    var text: String {
        switch self {
        case .home: "홈"
        case .profile: "프로필"
        }
    }
}

let data = [
    Item.home,
    Item.profile
]

struct MainView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var dialogProvider: DialogProvider
    @State private var selectedTab = data[0]
    
    var body: some View {
        MyBottomAppBar(data, selection: selectedTab) {
            selectedTab = $0
        } content: {
            switch selectedTab {
            case .home: HomeView()
            case .profile: ProfileView()
            }
        }
        .onAppear {
            handleGraduating(appState.graduating)
        }
        .onChange(of: appState.graduating) {
            selectedTab = .home
            handleGraduating($0)
        }
    }
    
    func handleGraduating(_ graduating: Graduating?) {
        if graduating == nil,
           let school = appState.school {
            appState.graduating = .init(id: -1, graduatingDay: nextFebruaryFirst(from: .now) ?? .now, schoolId: school.id)
            dialogProvider.present(
                .init(title: "등록하신 학교의 졸업 날짜를\n찾을 수 없습니다")
                .message("대신 졸업 날짜가 2월 1일로 설정 되었습니다!")
            )
        }
    }
}
