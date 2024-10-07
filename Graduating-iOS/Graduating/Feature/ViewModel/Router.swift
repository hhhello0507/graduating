import SwiftUI

public final class Router: ObservableObject {
    @Published public var path = NavigationPath()
}

extension Router {
    public func push(_ view: any Hashable) {
        self.path.append(view)
    }
    
    public func pop() {
        if !self.path.isEmpty {
            self.path.removeLast()
        }
    }
    
    public func toRoot() {
        self.path.removeLast(self.path.count)
    }
    
    public func replace(_ views: [any Hashable]) {
        toRoot()
        views.forEach {
            push($0)
        }
    }
}
