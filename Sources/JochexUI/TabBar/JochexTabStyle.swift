//
//  JochexTabStyle.swift
//  JochexUI
//
//  Created by Noah Johann on 19.03.26.
//

import SwiftUI

public struct JochexTabStyle: ButtonStyle {
    @State var isHovering: Bool = false
    
    let isSelected: Bool
        
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                if configuration.isPressed {
                    Rectangle().foregroundStyle(.quaternary)
                } else if isHovering || isSelected {
                    Rectangle().foregroundStyle(.quinary)
                }
            }
            .clipShape(.capsule)
       //     .aspectRatio(1, contentMode: .fit)
            .contentShape(.ellipse)
            .onHover { isHovering = $0 }
    }
}
