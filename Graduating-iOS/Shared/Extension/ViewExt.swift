//
//  ViewExt.swift
//  Shared
//
//  Created by hhhello0507 on 10/4/24.
//

import SwiftUI

public extension View {
    func frame(size: CGFloat?, alignment: Alignment = .center) -> some View {
        return self.frame(width: size, height: size, alignment: alignment)
    }
}
