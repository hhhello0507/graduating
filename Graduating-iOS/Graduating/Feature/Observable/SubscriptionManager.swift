import Combine

final class SubscriptionManager {
    var subscriptions = Set<AnyCancellable>()
    
    deinit {
        subscriptions.forEach {
            $0.cancel()
        }
    }
}
