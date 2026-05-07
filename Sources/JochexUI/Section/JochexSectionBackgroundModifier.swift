//
//  JochexSectionBackgroundModifier.swift
//  JochexUI
//
//  Created by Noah Johann on 07.05.26.
//

import SwiftUI

public struct JochexSectionBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorscheme
    @Environment(\.glassIfAvailable) private var useGlass
    @Environment(\.jochexCornerRadius) private var cornerRadius

    public func body(content: Content) -> some View {
        content
            .background {
                if #available(macOS 26, *), useGlass == true {
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(colorscheme == .dark ? .black.opacity(0.07) : .white.opacity(0.33))
                    }
                    .glassEffect(.clear, in: RoundedRectangle(cornerRadius: cornerRadius))
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(colorscheme == .dark ? AnyShapeStyle(.quinary) : AnyShapeStyle(.white.opacity(0.7)))
                        .overlay {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .strokeBorder(.quaternary)
                        }
                }
            }
    }
}
