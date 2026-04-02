//
//  JochexPane.swift
//  JochexUI
//
//  Created by Noah Johann on 02.04.26.
//

import SwiftUI

public struct JochexPane<Header, Content>: View where Header: View, Content: View {
    @ViewBuilder private var header: () -> Header
    @ViewBuilder private var content: () -> Content
    
    // MARK: - Init
    
    /// JochexPane with a view as the header
    public init(
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder content: @escaping () -> Content,
    ) {
        self.header = header
        self.content = content
    }
    
    /// JochexPane with localized text as header
    public init(
        _ headerKey: LocalizedStringKey,
        @ViewBuilder content: @escaping () -> Content,
    ) where Header == Text {
        self.init(header: { Text(headerKey) }, content: content)
    }
    
    /// JochexPane without a header
    public init(
        content: @escaping () -> Content
    ) where Header == EmptyView {
        self.init(header: { EmptyView() }, content: content)
    }
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            AutoScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 18) {
                    content()
                }
            }
        } .jochexBackground()
    }
}
