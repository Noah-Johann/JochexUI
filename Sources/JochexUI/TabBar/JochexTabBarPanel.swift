//
//  JochexTabBarPanel.swift
//  JochexUI
//
//  Created by Noah Johann on 22.03.26.
//

import AppKit

class JochexTabBarPanel: NSPanel {
    override var canBecomeKey: Bool { true }
    
    init() {
        super.init(
            contentRect: .zero,
            styleMask: [.nonactivatingPanel, .borderless],
            backing: .buffered,
            defer: false
        )
        isFloatingPanel = true
        isMovable = false
        isMovableByWindowBackground = false
        hidesOnDeactivate = false
        becomesKeyOnlyIfNeeded = true
        backgroundColor = .clear
        hasShadow = true
    }
    
}
