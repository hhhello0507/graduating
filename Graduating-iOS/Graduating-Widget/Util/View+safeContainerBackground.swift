//  Author: hhhello0507
//  Created: 10/10/24


import Foundation
import SwiftUI
import MyDesignSystem

extension View {
    @ViewBuilder
    nonisolated public func safeContainerBackground(
        alignment: Alignment = .center,
        color: Colorable
    ) -> some View {
        if #available(iOS 17.0, iOSApplicationExtension 17.0, *) {
            self.containerBackground(for: .widget) {
                color.box.color
            }
        } else {
            self
        }
    }
}
