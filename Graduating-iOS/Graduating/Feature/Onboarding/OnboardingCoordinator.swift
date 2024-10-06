import SwiftUI

public struct OnboardingCoordinator: View {
    @EnvironmentObject private var router: Router
    
    @StateObject private var viewModel = OnboardingViewModel()
}

extension OnboardingCoordinator {
    public var body: some View {
        EmptyView()
            .navigationDestination(for: OnboardingFirstView.Path.self) {
                OnboardingFirstView(path: $0)
                    .environmentObject(viewModel)
            }
            .navigationDestination(for: OnboardingSecondView.Path.self) {
                OnboardingSecondView(path: $0)
                    .environmentObject(viewModel)
            }
            .navigationDestination(for: OnboardingThirdView.Path.self) {
                OnboardingThirdView(path: $0)
                    .environmentObject(viewModel)
            }
            .navigationDestination(for: OnboardingFourthView.Path.self) {
                OnboardingFourthView(path: $0)
                    .environmentObject(viewModel)
            }
    }
}
