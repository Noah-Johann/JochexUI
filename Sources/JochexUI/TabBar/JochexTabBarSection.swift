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
                    if isExpanded && Header.self != Divider.self {
                        header()
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .padding(.top, 2)
                    } else {
                        Divider()
                    }
                }
                .frame(minHeight: 16)
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
