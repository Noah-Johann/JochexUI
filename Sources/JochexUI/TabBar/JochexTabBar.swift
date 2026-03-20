//
//  JochexTabBar.swift
//  JochexUI
//
//  Created by Noah Johann on 19.03.26.
//

import SwiftUI

public struct JochexTabBar<Tabs>: View where Tabs: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var isExpanded: Bool = false
    public var maxHeight: CGFloat = -1
    
    private var glass: Bool = true
    @ViewBuilder private var tabs: () -> Tabs
    
    // MARK: - Init
    
    /// Tab Bar without a maximum height
    public init(@ViewBuilder tabs: @escaping () -> Tabs) {
        self.tabs = tabs
    }
    
    /// Tab Bar with specified use of liquid glass
    public init(
        glass: Bool,
        @ViewBuilder tabs: @escaping () -> Tabs
    ) {
        self.glass = glass
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
    
    // MARK: - Body
    
    public var body: some View {
        VStack(spacing: 0) {
            tabs()
        }
        .padding(4)
        .background {
            if glass {
                RoundedRectangle(cornerRadius: 24)
                   .glassEffect(in: RoundedRectangle(cornerRadius: 24))
            } else {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1), lineWidth: 1)
                    )
            }
        }
        .frame(width: isExpanded ? nil : 52)
   //     .frame(maxHeight: maxHeight > 44 ? maxHeight : .infinity)
        .onHover { hovering in
            withAnimation(.bouncy(duration: 0.3)) {
                isExpanded = hovering }
        }
    }
}

// MARK: - Preview

private enum PreviewTab: JochexTabItem {
    case general
    case about
    case music
    case lockscreen
    case quit
    
    var id: Self { self }
    
    var name: LocalizedStringKey {
        switch self {
        case .general: "General"
        case .about: "About"
        case .music: "Music"
        case .lockscreen: "Shortcuts"
        case .quit: "Quit"
        }
    }
    
    var icon: Image {
        switch self {
        case .general: .init(systemName: "gear")
        case .about: .init(systemName: "info")
        case .music: .init(systemName: "music.note")
        case .lockscreen: .init(systemName: "keyboard")
        case .quit: .init(systemName: "power")
        }
    }
    
    
}

#Preview(
    "TabBar Glass",
    traits: .sizeThatFitsLayout
) {
    @Previewable @State var selection: PreviewTab = PreviewTab.general
    @Previewable @State var isExpanded: Bool = false
    
    VStack {
        JochexTabBar(glass: true) {
            JochexTabBarSection(
                selectedTab: $selection,
                isExpanded: $isExpanded,
                tabs: [PreviewTab.general, .about]
            )
            
            JochexTabBarSection(
                "Section title",
                selectedTab: $selection,
                isExpanded: $isExpanded,
                tabs: [PreviewTab.music, .lockscreen]
            )
            
            JochexTabBarSection(
                selectedTab: $selection,
                isExpanded: $isExpanded,
                tabs: [PreviewTab.quit]
            ) { Divider() }
        }
        .onHover { hovering in
            withAnimation(.bouncy(duration: 0.3)) {
                isExpanded = hovering }
        }
    }
    .frame(maxWidth: 150, alignment: .leading)
    .padding(20)
}

#Preview(
    "TabBar Material",
    traits: .sizeThatFitsLayout
) {
    @Previewable @State var selection: PreviewTab = PreviewTab.general
    @Previewable @State var isExpanded: Bool = false
    
    VStack {
        JochexTabBar(glass: false) {
            JochexTabBarSection(
                selectedTab: $selection,
                isExpanded: $isExpanded,
                tabs: [PreviewTab.general, .about]
            )
            
            JochexTabBarSection(
                "Section title",
                selectedTab: $selection,
                isExpanded: $isExpanded,
                tabs: [PreviewTab.music, .lockscreen]
            )
            
            JochexTabBarSection(
                selectedTab: $selection,
                isExpanded: $isExpanded,
                tabs: [PreviewTab.quit]
            ) { Divider() }
        }
        .onHover { hovering in
            withAnimation(.bouncy(duration: 0.3)) {
                isExpanded = hovering }
        }
    }
    .frame(maxWidth: 150, alignment: .leading)
    .padding(20)
}




