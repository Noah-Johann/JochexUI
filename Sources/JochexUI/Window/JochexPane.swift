//
//  JochexPane.swift
//  JochexUI
//
//  Created by Noah Johann on 02.04.26.
//

import SwiftUI

public struct JochexPane<Header, Content>: View where Header: View, Content: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.paneTitleHeight) private var titleBarHeight
    
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
            VStack {
                if #unavailable(macOS 26) {
                    VStack {
                        header()
                            .frame(height: titleBarHeight)
                        Divider()
                        Spacer()
                    }
                }
                
                AutoScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 18) {
                        content()
                    } .padding(.top, titleBarHeight)
                }
            }
            
            if #available(macOS 26, *) {
                VStack(spacing: 0) {
                    header()
                        .frame(height: titleBarHeight)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.black.opacity(colorScheme == .dark ? 0.2 : 0.1))
                        )
                        .glassEffect(.clear, in: RoundedRectangle(cornerRadius: 24))
                    // Divider()
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
        .jochexBackground()
    }
}
