import SwiftUI
import MyDesignSystem
import SignKit
import Shared

@main
struct GraduatingApp: App {
    @StateObject private var dialogProvider = DialogProvider()
    @StateObject private var datePickerProvider = DatePickerProvider()
    @StateObject private var timePickerProvider = TimePickerProvider()
    @StateObject private var customPaletteProvider = CustomPalette.Provider()
    @StateObject private var router = Router()
    @StateObject private var appState = AppState()
    
    @AppStorage("theme", store: .graduating) private var theme: Int = Palette.blue.rawValue
}

extension GraduatingApp {
    var body: some Scene {
        WindowGroup {
            CustomPalette.Presenter(provider: customPaletteProvider) {
                MyModalProvider(
                    dialogProvider: dialogProvider,
                    datePickerProvider: datePickerProvider,
                    timePickerProvider: timePickerProvider
                ) {
                    NavigationStack(path: $router.path) {
                        if appState.isLoggedIn {
                            MainCoordinator()
                        } else {
                            OnboardingCoordinator()
                        }
                    }
                }
            }
            .environmentObject(router)
            .environmentObject(appState)
            .registerWanted()
            .id(theme)
            .onAppear {
                // Setting theme
                if let palette = Palette(rawValue: theme) {
                    customPaletteProvider.updateColor(pallete: palette)
                }
                
                UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            }
            .onReceive(appState.$isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    router.registerRootView(MainPath())
                } else {
                    router.registerRootView(OnboardingFirstView.Path())
                }
            }
        }
    }
}

// For allow swipe back
// For hidden navigation bar
import UIKit

extension UINavigationController: UIKit.UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
