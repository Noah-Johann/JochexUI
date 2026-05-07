//
//  Environment+Extension.swift
//  JochexUI
//
//  Created by Noah Johann on 02.04.26.
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var glassIfAvailable: Bool = true
    
    @Entry var jochexCornerRadius: CGFloat = 12
    
    @Entry var paneTitleHeight: CGFloat = 52
    @Entry var paneTrafficLightInset: CGFloat = 90
    @Entry var paneHorizontalInset: CGFloat = 12
    @Entry var paneVerticalInset: CGFloat = 12
    
    @Entry var sectionHasDividers: Bool = true
}
