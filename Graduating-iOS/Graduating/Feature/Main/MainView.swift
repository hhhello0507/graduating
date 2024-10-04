import SwiftUI

import Model
import Shared

import MyDesignSystem

enum Item: BottomAppBarItem {
    case home
    case meal
    case profile
    
    var icon: Iconable {
        switch self {
        case .home: Icons.Feature.Home
        case .meal: Icons.Feature.Utensils
        case .profile: Icons.Feature.Person
        }
    }
    var text: String {
        switch self {
        case .home: "홈"
        case .meal: "급식"
        case .profile: "프로필"
        }
    }
}

let data = [
    Item.home,
    Item.meal,
    Item.profile
]

struct MainPath: Hashable {}

struct MainView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var dialogProvider: DialogProvider
    
    @StateObject private var mealViewModel = MealViewModel()
    @StateObject private var graduatingViewModel = GraduatingViewModel()
    
    @State private var selectedTab = data[0]
    
    private let path: MainPath
    
    init(_ path: MainPath) {
        self.path = path
    }
    
    var body: some View {
        MyBottomAppBar(data, selection: selectedTab) {
            selectedTab = $0
        } content: {
            switch selectedTab {
            case .home: HomeView()
                    .environmentObject(graduatingViewModel)
            case .meal: MealView()
                    .environmentObject(mealViewModel)
            case .profile: ProfileView()
            }
        }
        .onAppear {
            handleGraduating(appState.graduating)
            fetchMeals()
            fetchGraduating()
        }
        .onChange(of: appState.graduating) {
            selectedTab = .home
            handleGraduating($0)
        }
    }
}

extension MainView {
    func handleGraduating(_ graduating: Graduating?) {
        if appState.graduatingFetchFailure,
           let school = appState.school {
            appState.graduating = .init(id: -1, graduatingDay: nextFebruaryFirst(from: .now) ?? .now, schoolId: school.id)
            dialogProvider.present(
                .init(title: "등록하신 학교의 졸업 날짜를\n찾을 수 없습니다")
                .message("대신 졸업 날짜가 2월 1일로 설정 되었습니다!")
            )
        }
    }
    
    func fetchMeals() {
        guard let school = appState.school else { return }
        mealViewModel.fetchMeals(schoolId: school.id)
    }
    
    func fetchGraduating() {
        guard let grade = appState.grade,
              let graduating = appState.graduating else {
            return
        }
        let limit = appState.school?.type?.limit ?? 3
        graduatingViewModel.observe(grade: grade, graduating: graduating, limit: limit)
    }
}
