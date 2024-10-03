import Combine

public extension Publisher {
    func ignoreError() -> AnyPublisher<Output, Never> {
        return self.catch { _ in
            Empty<Output, Never>()
        }
        .eraseToAnyPublisher()
    }
}

// Allow to assign Optional value
public extension Publisher where Failure == Never {
    func assign<Root: AnyObject>(to path: ReferenceWritableKeyPath<Root, Output?>, on instance: Root) -> Cancellable {
        sink { instance[keyPath: path] = $0 }
    }
}
