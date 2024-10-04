import SwiftUI

struct MainCoordinator: View {
    
    var body: some View {
        EmptyView()
            .navigationDestination(for: MainPath.self) { MainView($0) }
            .navigationDestination(for: EditSchoolPath.self) { EditSchoolView($0) }
            .navigationDestination(for: EditGradePath.self) { EditGradeView($0) }
            .navigationDestination(for: SettingPath.self) { _ in SettingView() }
            .navigationDestination(for: EditProfilePath.self) { _ in EditProfileView() }
    }
}
