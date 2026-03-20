//
//  JochexTabBarSection.swift
//  JochexUI
//
//  Created by Noah Johann on 19.03.26.
//

import SwiftUI

public struct JochexTabBarSection<Header, Tab>: View where Header: View, Tab: JochexTabItem {
    @Binding var selectedTab: Tab
    @Binding var isExpanded: Bool
    
    
    private let tabs: [Tab]
    
    @ViewBuilder private var header: () -> Header
    
    // MARK: - Init
    
    /// VIew as section header
    public init(
        selectedTab: Binding<Tab>,
        isExpanded: Binding<Bool>,
        tabs: [Tab],
        @ViewBuilder header: @escaping () -> Header
    ) {
        self._selectedTab = selectedTab
        self._isExpanded = isExpanded
        self.tabs = tabs
        self.header = header
    }
    
    /// LocalizedString as section header
    public init(
        _ title: LocalizedStringKey,
        selectedTab: Binding<Tab>,
        isExpanded: Binding<Bool>,
        tabs: [Tab],
    ) where Header == Text {
        self.init(
            selectedTab: selectedTab,
            isExpanded: isExpanded,
            tabs: tabs
        ) {
            Text(title)
        }
    }
    
    /// Section without header
    public init(
        selectedTab: Binding<Tab>,
        isExpanded: Binding<Bool>,
        tabs: [Tab],
    ) where Header == EmptyView {
        self.init(
            selectedTab: selectedTab,
            isExpanded: isExpanded,
            tabs: tabs
        ) {
            EmptyView()
        }
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if Header.self != EmptyView.self {
                Group {
                    if isExpanded {
                    
                        header()
                            .foregroundStyle(.secondary)
                            .font(.callout)
                    } else {
                        Divider()
                    }
                }
                .frame(minHeight: 9)
                .padding(.vertical, 3)
                .padding(.horizontal, 11)
                .foregroundStyle(.secondary)
                .transition(.blurReplace)
            }
            ForEach(tabs) { tab in
                JochexTab(isExpanded: $isExpanded, selectedTab: $selectedTab, tab: tab)
            }
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
    "TabBarSection",
    traits: .sizeThatFitsLayout
) {
    @Previewable @State var selection: PreviewTab = PreviewTab.general
    @Previewable @State var isExpanded: Bool = false
    
    VStack {
        JochexTabBar {
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
            ) { EmptyView() }
        }
        .onHover { hovering in
            withAnimation(.bouncy(duration: 0.3)) {
                isExpanded = hovering }
        }
    }
    .frame(maxWidth: 170, alignment: .leading)
    .padding(20)
}
