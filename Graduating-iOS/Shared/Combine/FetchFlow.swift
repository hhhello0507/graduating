//
//  FetchFlo.swift
//  Shared
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation
import Combine

public enum Flow {
    case idle
    case fetching
    case success
    case failure(Error)
    case finished
}

public extension Publisher {
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
