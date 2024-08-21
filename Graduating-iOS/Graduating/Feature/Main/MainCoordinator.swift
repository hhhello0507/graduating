import SwiftUI
import MyDesignSystem

enum Item: BottomAppBarItem {
    
    case home
    case setting
    
    var icon: Iconable {
        switch self {
        case .home: Icons.Feature.Home
        case .setting: Icons.Feature.Setting
        }
    }
    var text: String {
        switch self {
        case .home: "홈"
        case .setting: "설정"
        }
    }
}

let data = [
    Item.home,
    Item.setting
]

struct MainCoordinator: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    @State private var selectedTab = data[0]
    
    var body: some View {
        MyBottomAppBar(data, selection: selectedTab) {
            selectedTab = $0
        } content: {
            switch selectedTab {
            case .home: HomeView()
            case .setting: ProfileView()
            }
        }
        .navigationDestination(for: OnboardingInMainDestination.self) { dest in
            Group {
                switch dest {
                case .onboardingFirst: OnboardingFirstView()
                case .onboardingSecond: OnboardingSecondView()
                }
            }
            .environmentObject(onboardingViewModel)
        }
    }
}
