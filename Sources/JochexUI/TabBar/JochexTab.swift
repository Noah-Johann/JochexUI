//
//  JochexTab.swift
//  JochexUI
//
//  Created by Noah Johann on 19.03.26.
//

import SwiftUI

public struct JochexTab<Tab>: View where Tab: JochexTabItem {
    @State var isKey: Bool = false
    @Binding var isExpanded: Bool
    @Binding var selectedTab: Tab
    private var tab: Tab
    
    // MARK: - Init
    
    public init(isExpanded: Binding<Bool>, selectedTab: Binding<Tab>, tab: Tab) {
        self._isExpanded = isExpanded
        self._selectedTab = selectedTab
        self.tab = tab
    }
    
    // MARK: - Body
    
    public var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.1)) {
                selectedTab = tab
            }
        } label: {
            tabLabel(tab: tab)
                .foregroundStyle(isKey ? Color.primary : Color.secondary)
        }
        .buttonStyle(JochexTabStyle(isSelected: isKey))
        .onChange(of : selectedTab) { isKey = tabIsKey() }
        .onAppear { isKey = tabIsKey() }
    }
    
    private func tabLabel(tab: Tab) -> some View {
        HStack {
            tab.icon
                .frame(minWidth: 44, minHeight: 44)
                .imageScale(.large)
            if isExpanded {
                Text(tab.name)
                    .padding(.trailing)
            }
        }
        // Full width buttons
        .frame(maxWidth: isExpanded ? .infinity : 44, alignment: .leading)
    }
    
    private func tabIsKey() -> Bool {
        return selectedTab == tab
    }
}
