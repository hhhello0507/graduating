import SwiftUI

struct MainCoordinator: View {
    var body: some View {
        MainView()
            .navigationDestination(for: EditSchoolView.Path.self) { EditSchoolView(path: $0) }
            .navigationDestination(for: EditGraduatingYearView.Path.self) { EditGraduatingYearView(path: $0) }
            .navigationDestination(for: SettingPath.self) { _ in SettingView() }
            .navigationDestination(for: EditProfilePath.self) { _ in EditProfileView() }
            .navigationDestination(for: ScholarshipDetailView.Path.self) { ScholarshipDetailView(path: $0) }
    }
}
