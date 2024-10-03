//
//  ViewExt.swift
//  Graduating
//
//  Created by hhhello0507 on 10/4/24.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func onReadSize(_ perform: @escaping (CGSize) -> Void) -> some View {
        self.customBackground {
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: perform)
    }
    
    @ViewBuilder
    func customBackground<V: View>(alignment: Alignment = .center, @ViewBuilder content: () -> V) -> some View {
        self.background(alignment: alignment, content: content)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

struct AdjustedHeightSheetViewModifier: ViewModifier {
    
    @State private var size: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .onReadSize {
                self.size = $0
            }
            .presentationDetents([.height(size.height)])
    }
}

public extension View {
    func adjustedHeightSheet() -> some View {
        self.modifier(AdjustedHeightSheetViewModifier())
    }
}
