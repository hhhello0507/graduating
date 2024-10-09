import SwiftUI
import GoogleMobileAds

public struct GoogleAdBannderView: UIViewControllerRepresentable {
    private let adUnitId: String
    init(adUnitId: String) {
        self.adUnitId = adUnitId
    }
    
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
        banner.adUnitID = adUnitId
#endif
        banner.load(GADRequest())
        return viewController
    }
    
    public func updateUIViewController(_ viewController: UIViewController, context: Context) {}
}

public extension GoogleAdBannderView {
    struct Presenter<Label: View>: View {
        public enum Inset {
            case top
            case bottom
        }
        
        public let inset: Inset
        public let adUnitId: String
        public let label: () -> Label
        
        public init(
            inset: Inset,
            adUnitId: String,
            @ViewBuilder label: @escaping () -> Label
        ) {
            self.inset = inset
            self.adUnitId = adUnitId
            self.label = label
        }
        
        public var body: some View {
            VStack(spacing: 0) {
                switch inset {
                case .top:
                    banner
                    label()
                case .bottom:
                    label()
                    banner
                }
            }
        }
        
        private var banner: some View {
            GoogleAdBannderView(adUnitId: adUnitId)
                .frame(width: UIScreen.main.bounds.width, height: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
        }
    }
}

public extension View {
    func googleBannderAd(
        inset: GoogleAdBannderView.Presenter<Self>.Inset,
        adUnitId: String
    ) -> some View {
        GoogleAdBannderView.Presenter(inset: inset, adUnitId: adUnitId) { self }
    }
}
