//
//  SignInExt.swift
//  Data
//
//  Created by hhhello0507 on 10/4/24.
//

import Foundation
import SignKit

public extension Sign {
    static var me: Sign {
        Sign(store: .init(.graduating))
    }
}
