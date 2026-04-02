//
//  JochexWindowBackgroundModifier.swift
//  JochexUI
//
//  Created by Noah Johann on 02.04.26.
//  Source: https://github.com/MrKai77/Luminare/blob/main/Sources/Luminare/Components/Auxiliary/Modifiers/LuminareBackgroundEffectModifier.swift
//

import SwiftUI

public struct JochexWindowBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorscheme

    public func body(content: Content) -> some View {
        content
            .background {
                ZStack {
                    MaterialView(
                        material: .menu,
                        blendingMode: .behindWindow
                    )

                    Rectangle()
                        .foregroundStyle(.tint)
                        .opacity(colorscheme == .light ? 0.025 : 0.1)
                        .blendMode(.multiply)
                }
                .compositingGroup()
                .ignoresSafeArea()
                .allowsHitTesting(false)
            }
    }
}
