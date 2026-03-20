//
//  JochexTabBar.swift
//  JochexUI
//
//  Created by Noah Johann on 19.03.26.
//

import SwiftUI

public struct JochexTabBar<Tabs>: View where Tabs: View {
    @State private var isExpanded: Bool = false
    public var maxHeight: CGFloat = -1
    
    @ViewBuilder private var tabs: () -> Tabs
    
    /// Tab Bar without a maximum height
    public init(@ViewBuilder tabs: @escaping () -> Tabs) {
        self.tabs = tabs
    }
    
    /// Tab Bar with a specified maximum height
//    public init(
//        maxHeight: CGFloat,
//        @ViewBuilder tabs: @escaping () -> Tabs
//    ) {
//        self.maxHeight = maxHeight
//        self.tabs = tabs
//    }
    
    public var body: some View {
        VStack(spacing: 0) {
            tabs()
        }
        .padding(4)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(.ultraThinMaterial)
             //   .glassEffect(in: RoundedRectangle(cornerRadius: 24))
        }
        .frame(width: isExpanded ? nil : 52)
   //     .frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, alignment: .leading)
   //     .frame(maxHeight: maxHeight > 44 ? maxHeight : .infinity)
        .onHover { hovering in
            withAnimation(.bouncy(duration: 0.3)) {
                isExpanded = hovering }
        }
    }
}




