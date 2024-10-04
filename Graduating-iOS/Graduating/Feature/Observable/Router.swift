import SwiftUI

public final class Router: ObservableObject {
    @Published public var path = NavigationPath()
}

extension Router {
    public func push(_ view: any Hashable) {
        path.append(view)
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func toRoot() {
        path.removeLast(path.count)
    }
    
    public func replace(_ views: [any Hashable]) {
        toRoot()
        views.forEach {
            push($0)
        }
    }
}
