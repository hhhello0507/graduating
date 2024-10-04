import Combine

open class BaseViewModel: ObservableObject {
    public var subscriptions = Set<AnyCancellable>()
    
    deinit {
        subscriptions.forEach {
            $0.cancel()
        }
    }
}
