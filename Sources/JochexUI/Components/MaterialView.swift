//
//  MaterialView.swift
//  JochexUI
//
//  Created by Noah Johann on 02.04.26.
//

import SwiftUI

struct MaterialView: NSViewRepresentable {
    let material: NSVisualEffectView.Material
    let blendingMode: NSVisualEffectView.BlendingMode
    
    func makeNSView(context _: Context) -> NSVisualEffectView {
        let materialView = NSVisualEffectView()
        materialView.material = material
        materialView.blendingMode = blendingMode
        materialView.isEmphasized = true
        return materialView
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}
