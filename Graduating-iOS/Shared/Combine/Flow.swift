import Foundation
import SwiftUI
import Combine

public enum Flow {
    case idle
    case fetching
    case success
    case failure(Error)
    case finished
}

public extension Publisher {
    
    @inlinable
    func flow<Object: AnyObject>(
        _ keyPath: ReferenceWritableKeyPath<Object, Flow>,
        on object: Object
    ) -> AnyPublisher<Output, Failure> {
        self.handleEvents(
            receiveSubscription: { _ in
                object[keyPath: keyPath] = .fetching
            },
            receiveOutput: { _ in
                object[keyPath: keyPath] = .success
            },
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    object[keyPath: keyPath] = .finished
                case .failure(let error):
                    object[keyPath: keyPath] = .failure(error)
                }
            },
            receiveCancel: {
                object[keyPath: keyPath] = .idle
            }
        )
        .eraseToAnyPublisher()
    }
}
