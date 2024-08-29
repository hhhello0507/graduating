//
//  ScopeExt.swift
//  Shared
//
//  Created by hhhello0507 on 8/28/24.
//

import Foundation

@inlinable
public func run<T>(
    block: () -> T
) -> T {
    return block()
}
