import SwiftUI
import MyDesignSystem

enum Item: BottomAppBarItem {
    
    case home
    
    var icon: Iconable {
        switch self {
        case .home: Icons.Feature.Home
        }
    }
    var text: String {
        switch self {
        case .home: "홈"
        }
    }
}

let data = [
    Item.home
]

struct MainCoordinator: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            view
        }
    }
    
    @State private var selectedTab = data[0]
    
    var view: some View {
        MyBottomAppBar(data, selection: selectedTab) {
            selectedTab = $0
        } content: {
            switch selectedTab {
            case .home: HomeView()
            }
        }
    }
}
