//
//  JochexWindowView.swift
//  JochexUI
//
//  Created by Noah Johann on 02.04.26.
//

import SwiftUI

public struct JochexWindowView<Content>: View where Content: View {
    @ViewBuilder public let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content()
    }
}
