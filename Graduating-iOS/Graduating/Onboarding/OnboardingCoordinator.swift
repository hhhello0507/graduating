import SwiftUI

public struct OnboardingCoordinator: View {
    
    @EnvironmentObject var router: Router
    
    public var body: some View {
        NavigationStack(path: $router.path) {
            OnboardingFirstView()
                .navigationDestination(for: OnboardingDestination.self) { dest in
                    switch dest {
                    case .onboardingFirst: OnboardingFirstView()
                    case .onboardingSecond: OnboardingSecondView()
                    }
                }
        }
    }
}
