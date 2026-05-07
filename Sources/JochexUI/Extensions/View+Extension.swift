//
//  View+Extension.swift
//  JochexUI
//
//  Created by Noah Johann on 02.04.26.
//

import SwiftUI

public extension View {
    func jochexBackground() -> some View {
        modifier(JochexWindowBackgroundModifier())
    }
    
    func jochexSectionBackground() -> some View {
        modifier(JochexSectionBackgroundModifier())
    }
    
    public func jochexUseGlassIfAvailable(_ using: Bool) -> some View {
        self
            .environment(\.glassIfAvailable, using)
    }
}
