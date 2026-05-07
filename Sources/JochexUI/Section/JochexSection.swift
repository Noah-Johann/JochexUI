//
//  JochexSection.swift
//  JochexUI
//
//  Created by Noah Johann on 04.04.26.
//

import SwiftUI

enum SectionHeaderLayout {
    case integrated
    case seperated
}

public struct JochexSection<Content, Header, Footer>: View where Content: View, Header: View, Footer: View {
    @ViewBuilder private var content: () -> Content
    @ViewBuilder private var header: () -> Header
    @ViewBuilder private var footer: () -> Footer
    
    private var hasHeader: Bool { Header.self != EmptyView.self }
    private var hasFooter: Bool { Footer.self != EmptyView.self }
    
    @Environment(\.sectionHasDividers) private var hasDividers
    @Environment(\.jochexCornerRadius) private var cornerRadius
    
    
    // MARK: - Init
    
    // Section with a header and a footer
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self.content = content
        self.header = header
        self.footer = footer
    }
    
    // Section with a localized header and footer
    public init(
        @ViewBuilder content: @escaping () -> Content,
        _ headerKey: LocalizedStringKey,
        _ footerKey: LocalizedStringKey
    ) where Header == Text, Footer == Text {
        self.init {
            content()
        } header: {
            Text(headerKey)
                .fontWeight(.medium)
        } footer: {
            Text(footerKey)
        }
    }
    
    // Section with a header
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> Header
    ) where Footer == EmptyView {
        self.init {
            content()
        } header: {
            header()
        } footer: {
            EmptyView()
        }
    }
    
    // Section with a localized header
    public init(
        @ViewBuilder content: @escaping () -> Content,
        _ headerKey: LocalizedStringKey
    ) where Header == Text, Footer == EmptyView {
        self.init {
            content()
        } header: {
            Text(headerKey)
                .fontWeight(.medium)
        } footer: {
            EmptyView()
        }
    }
    
    // Section with a footer
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder footer: @escaping () -> Footer
    ) where Header == EmptyView {
        self.init {
            content()
        } header: {
            EmptyView()
        } footer: {
            footer()
        }
    }
    
    // Section with a localized footer
    public init(@ViewBuilder content: @escaping () -> Content, _ footerKey: LocalizedStringKey) where Header == EmptyView, Footer == Text {
        self.init {
            content()
        } header: {
            EmptyView()
        } footer: {
            Text(footerKey)
        }
    }
    
    // Section without a header and footer
    public init(@ViewBuilder content: @escaping () -> Content) where Header == EmptyView, Footer == EmptyView {
        self.init {
            content()
        } header: {
            EmptyView()
        } footer: {
            EmptyView()
        }
    }
    
    
    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading) {
            contentHeader()
            
            sectionContent()
            
            contentFooter()
        }
    }
    
    @ViewBuilder private func sectionContent() -> some View {
        JochexSectionStack {
            content()
        }
        .compositingGroup()
        .jochexSectionBackground()

    }
    
    @ViewBuilder private func contentHeader() -> some View {
        if hasHeader {
            header()
                .foregroundStyle(.secondary)
                .padding(.horizontal, cornerRadius)
                .padding(.bottom, 2)
        }
    }
    
    @ViewBuilder private func contentFooter() -> some View {
        if hasFooter {
            footer()
                .foregroundStyle(.secondary)
                .padding(.horizontal, cornerRadius)
                .padding(.top, 2)
        }
    }
    
    
}

#Preview {
    JochexSection {
        VStack(alignment: .leading) {
            Image(systemName: "apple.logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 32)
                .foregroundStyle(.secondary)
        }
        .frame(height: 100)

//        Button(
//            "Button",
//            "Click Me!"
//        ) {}

        Text("""
        Lorem eu cupidatat consectetur cupidatat est labore irure dolore dolore deserunt consequat. \
        Proident non est aliquip consectetur quis dolor. Incididunt aute do ea fugiat dolor. \
        Cillum cillum enim exercitation dolor do. \
        Deserunt ipsum aute non occaecat commodo adipisicing non. In est incididunt esse et.
        """)
        .padding(8)
        .foregroundStyle(.secondary)
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity, alignment: .leading)
    } header: {
        HStack(alignment: .bottom) {
            Text("Section Header")

            Spacer()

            HStack(alignment: .bottom) {
                Button {} label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(.tint)
                }

                Button {} label: {
                    Image(systemName: "location")
                }
            }
            .buttonStyle(.borderless)
        }
    } footer: {
        HStack {
            Text("Section Footer")

            Spacer()
        }
    }
    .environment(\.glassIfAvailable, false)
    .frame(width: 450)
}

