//
//  JochexTabItem.swift
//  JochexUI
//
//  Created by Noah Johann on 19.03.26.
//

import SwiftUI

public protocol JochexTabItem: Equatable, Identifiable {
    var name: LocalizedStringKey { get }
    
    associatedtype IconView: View
    var icon: IconView { get }
}
