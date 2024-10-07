import SwiftUI
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

struct MainView {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var dialogProvider: DialogProvider
    
    @StateObject private var mealViewModel = MealViewModel()
    
    @State private var selectedTab = data[0]
    
    init() {}
}

extension MainView: View {
    var body: some View {
        MyBottomAppBar(data, selection: selectedTab) {
            selectedTab = $0
        } content: {
            switch selectedTab {
            case .home: HomeView()
            case .meal: MealView()
                    .environmentObject(mealViewModel)
            case .profile: ProfileView()
            }
        }
        .onAppear {
            mealViewModel.fetchMeals()
        }
    }
}
