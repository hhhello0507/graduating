import SwiftUI

public struct OnboardingCoordinator: View {
    @EnvironmentObject var router: Router
}

extension OnboardingCoordinator {
    public var body: some View {
        OnboardingFirstView()
            .navigationDestination(for: EditGradePath.self) {
                EditGradeView($0)
            }
    }
}
