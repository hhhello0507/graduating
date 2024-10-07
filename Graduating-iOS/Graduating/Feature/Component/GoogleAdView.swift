import SwiftUI
import GoogleMobileAds

public struct GoogleAdView: UIViewControllerRepresentable {
    public func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let bannerSize = GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width)
        let banner = GADBannerView(adSize: bannerSize)
        banner.rootViewController = viewController
        viewController.view.addSubview(banner)
        viewController.view.frame = CGRect(origin: .zero, size: bannerSize.size)
#if DEBUG
        banner.adUnitID = "ca-app-pub-3940256099942544/2435281174"
#else
        banner.adUnitID = "ca-app-pub-2589637472995872/3554240467"
#endif
        banner.load(GADRequest())
        return viewController
    }
    
    public func updateUIViewController(_ viewController: UIViewController, context: Context) {}
}

public extension GoogleAdView {
    struct BottomBannerPresenter<Banner: View, Label: View>: View {
        public let banner: () -> Banner
        public let label: () -> Label
        
        public init(
            @ViewBuilder banner: @escaping () -> Banner,
            @ViewBuilder label: @escaping () -> Label
        ) {
            self.banner = banner
            self.label = label
        }
        
        public var body: some View {
            VStack(spacing: 0) {
                banner()
                label()
            }
        }
    }
}
