import SwiftUI

public final class Router: ObservableObject {
    @Published public var path = NavigationPath()
    var rootView: (any Hashable)?
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
        if let rootView {
            path.append(rootView)
        }
    }
    
    public func replace(_ views: [any Hashable]) {
        toRoot()
        views.forEach {
            push($0)
        }
    }
    
    public func registerRootView(_ rootView: any Hashable) {
        self.rootView = rootView
        self.push(rootView)
    }
}
