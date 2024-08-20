import SwiftUI

public struct OnboardingCoordinator: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = OnboardingViewModel()
    
    public var body: some View {
        NavigationStack(path: $router.path) {
            OnboardingFirstView()
                .navigationDestination(for: OnboardingDestination.self) { dest in
                    Group {
                        switch dest {
                        case .onboardingFirst: OnboardingFirstView()
                        case .onboardingSecond: OnboardingSecondView()
                        }
                    }
                }
        }
        .environmentObject(viewModel)
    }
}
