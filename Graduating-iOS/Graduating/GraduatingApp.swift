import SwiftUI
import Shared
import MyDesignSystem
import SignKit
import GoogleMobileAds
import AdSupport
import AppTrackingTransparency

@main
struct GraduatingApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject private var dialogProvider = DialogProvider()
    @StateObject private var datePickerProvider = DatePickerProvider()
    @StateObject private var timePickerProvider = TimePickerProvider()
    @StateObject private var customPaletteProvider = CustomPalette.Provider()
    @StateObject private var router = Router()
    @StateObject private var appState = AppState()
    
    @AppStorage("theme", store: .graduating) private var theme: Int = Palette.blue.rawValue
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
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
                        if appState.shouldSignUp {
                            OnboardingCoordinator()
                        } else {
                            MainCoordinator()
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
            .onChange(of: appState.shouldSignUp) { _ in
                router.toRoot()
            }
            .onChange(of: scenePhase) { phase in
                if case .active = phase {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        print("App - ", terminator: "")
                        switch status {
                        case .authorized:           // 허용됨
                            print("Authorized")
                            print("IDFA = \(ASIdentifierManager.shared().advertisingIdentifier)")
                        case .denied:               // 거부됨
                            print("Denied")
                        case .notDetermined:        // 결정되지 않음
                            print("Not Determined")
                        case .restricted:           // 제한됨
                            print("Restricted")
                        @unknown default:           // 알려지지 않음
                            print("Unknow")
                        }
                    }
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
