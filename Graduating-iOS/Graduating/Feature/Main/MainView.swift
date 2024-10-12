import SwiftUI
import Shared
import MyDesignSystem

struct MainView {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var dialogProvider: DialogProvider
    
    @State private var selection = 0
    
    init() {}
}

extension MainView: View {
    var body: some View {
        MyBottomAppBar(selection: $selection) {
            HomeView()
                .page(icon: Icons.Feature.Home, text: "홈")
            MealView()
                .page(icon: Icons.Feature.Utensils, text: "급식")
            BenefitView()
                .page(icon: Icons.Feature.Star, text: "혜택")
//            ExploreView() // TODO: 탐색탭? 다음 업데이트 때 고려해볼 것
//                .page(icon: Icons.ETC.Search, text: "탐색")
            ProfileView()
                .page(icon: Icons.Feature.Person, text: "프로필")
        }
    }
}
