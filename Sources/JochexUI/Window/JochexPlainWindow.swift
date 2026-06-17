//
//  JochexPlainWindow.swift
//  JochexUI
//
//  Created by Noah Johann on 17.06.26.
//

import SwiftUI
import AppKit

public class JochexPlainWindow: JochexWindow {
    public init(
        windowWidth: CGFloat = 300,
        windowHeight: CGFloat = 380,
        content: @escaping () -> some View
    ) {
        super.init(
            width: windowWidth,
            height: windowHeight
        ) {
            ZStack {
                content()
                    .safeAreaPadding(.top, 50)
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .jochexBackground()
        }
    }
}
