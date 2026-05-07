//
//  JochexSectionStack.swift
//  JochexUI
//
//  Created by Noah Johann on 06.04.26.
//  Source: https://github.com/MrKai77/Luminare/blob/main/Sources/Luminare/Components/Section/LuminareSectionStack.swift
//

import SwiftUI
import VariadicViews


/// A vertical stack with optional dividers between elements.
public struct JochexSectionStack<Content>: View where Content: View {
    private let hasDividers: Bool

    @ViewBuilder private var content: () -> Content

    // MARK: - Init

    // Stack with divided content
    public init(
        hasDividers: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.hasDividers = hasDividers
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        UnaryVariadicView(content()) { children in
            DividedVStackVariadic(
                children: children,
                hasDividers: hasDividers
            )
        }
    }
}

// MARK: - Layouts

struct DividedVStackVariadic: View {
    let children: VariadicViewChildren
    let innerPadding: CGFloat
    let hasDividers: Bool

    init(
        children: VariadicViewChildren,
        innerPadding: CGFloat = 4,
        hasDividers: Bool
    ) {
        self.children = children
        self.innerPadding = innerPadding
        self.hasDividers = hasDividers
    }

    var body: some View {
        let first = children.first?.id
        let last = children.last?.id

        VStack(spacing: 0) {
            ForEach(children) { child in
                JochexSectionStackChildView(
                    child: child,
                    innerPadding: innerPadding,
                    isFirstChild: child.id == first,
                    isLastChild: child.id == last
                )

                if hasDividers, child.id != last {
                    Divider()
                        .padding(.horizontal, 1)
                }
            }
        }
    }
}

struct JochexSectionStackChildView: View {
    let child: VariadicViewChildren.Element
    let innerPadding: CGFloat
    let isFirstChild: Bool
    let isLastChild: Bool

    var body: some View {
        child
            .compositingGroup()
            .padding(innerPadding)
            .padding(.top, isFirstChild ? 1 : 0)
            .padding(.bottom, isLastChild ? 1 : 0)
            .padding(.horizontal, 1)
    }
}

// MARK: - Preview

#Preview {
    JochexSection {
        JochexSectionStack {
            ForEach(37 ..< 43) { num in
                Text("\(num)")
            }
        }
    }
    .padding()
}
