//
//  JochexWindow.swift
//  JochexUI
//
//  Created by Noah Johann on 22.03.26.
//

import SwiftUI
import AppKit

public class JochexWindow: NSWindow {
    private var windowHeight: CGFloat
    private var windowWidth: CGFloat
    
    private var observer: Any?
    private var tabBarPanel: JochexTabBarPanel?
    private var tabBarFactory: (() -> AnyView)?

    // MARK: - Init
    
    /// Jochex Window without a tab bar
    public init(width: CGFloat = 475, height: CGFloat = 550, content: @escaping () -> some View) {
        self.windowWidth = width
        self.windowHeight = height
        
        super.init(
            contentRect: .zero,
            styleMask: [.titled, .fullSizeContentView, .closable],
            backing: .buffered,
            defer: false
        )
        
        let view = NSView()
        let jochexWindowView = NSHostingView(rootView: JochexWindowView(content: content).frame(width: width, height: height))
        view.addSubview(jochexWindowView)

        jochexWindowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jochexWindowView.topAnchor.constraint(equalTo: view.topAnchor),
            jochexWindowView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            jochexWindowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jochexWindowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        contentView = view
        titlebarAppearsTransparent = true
        super.layoutIfNeeded()
    }
    
    /// Jochex Window with a tab bar
    public init(width: CGFloat = 475, height: CGFloat = 550, content: @escaping () -> some View, tabBar: @escaping () -> some View) {
        self.windowWidth = width
        self.windowHeight = height
        
        super.init(
            contentRect: .zero,
            styleMask: [.titled, .fullSizeContentView, .closable],
            backing: .buffered,
            defer: false
        )
        
        let view = NSView()
        let jochexWindowView = NSHostingView(rootView: JochexWindowView(content: content).frame(width: width, height: height))
        view.addSubview(jochexWindowView)

        jochexWindowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jochexWindowView.topAnchor.constraint(equalTo: view.topAnchor),
            jochexWindowView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            jochexWindowView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jochexWindowView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        contentView = view
        titlebarAppearsTransparent = true
        isReleasedWhenClosed = true
        self.toolbar = NSToolbar()
        super.layoutIfNeeded()
        self.tabBarFactory = { AnyView(tabBar()) }
        attachTabBar(tabBar: { AnyView(tabBar()) })
        addMoveObservers()
    }
    
    @MainActor deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    @objc dynamic var _cornerRadius: CGFloat {
        if #available(macOS 26, *) {
            24
        } else {
            12
        }
    }
    
    override public func makeKeyAndOrderFront(_ sender: Any?) {
        super.makeKeyAndOrderFront(sender)
        if tabBarPanel == nil, let tabBarFactory {
            attachTabBar(tabBar: tabBarFactory)
        }
    }

    override public func orderFrontRegardless() {
        super.orderFrontRegardless()
        if tabBarPanel == nil, let tabBarFactory {
            attachTabBar(tabBar: tabBarFactory)
        }
    }
    
    // MARK: - Tab Bar
    
    private func attachTabBar(tabBar: @escaping () -> AnyView) {
        if let existing = self.tabBarPanel {
            positionPanel(existing)
            addChildWindow(existing, ordered: .above)
            return
        }
        let panel = JochexTabBarPanel()
        let panelContent = HStack(spacing: 0) {
            tabBar()
                .padding(.leading, 1)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

        panel.contentView = NSHostingView(rootView: panelContent)
        panel.isReleasedWhenClosed = true
        positionPanel(panel)
        addChildWindow(panel, ordered: .above)
        self.tabBarPanel = panel
        
        
    }
    
    private func positionPanel(_ panel: JochexTabBarPanel) {
        let panelFrame = CGRect(
            x: frame.minX - 52 - 15, // Tabbar width minus window distance
            y: frame.midY - windowHeight / 2,
            width: 200,
            height: windowHeight
        )
        panel.setFrame(panelFrame, display: true)
    }
    
    private func addMoveObservers() {
        observer = NotificationCenter.default.addObserver(
            forName: NSWindow.didMoveNotification,
            object: self,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                guard let self, let panel = self.tabBarPanel else { return }
                self.positionPanel(panel)
            }
        }
    }
    
    override public func close() {
        if let panel = tabBarPanel {
            self.removeChildWindow(panel)
            panel.orderOut(nil)
        }
        tabBarPanel = nil
        if let observer {
            NotificationCenter.default.removeObserver(observer)
        }
        super.close()
    }
}

