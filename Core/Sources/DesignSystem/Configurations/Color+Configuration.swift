//
//  Color+Configuration.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import SwiftUI

public enum Color {}

extension Color {
    public struct Configuration {
        public var primary: SwiftUI.Color = .blue
        public var secondary: SwiftUI.Color = .orange
        public var background: SwiftUI.Color = .init(.systemBackground)
        
        public var text: SwiftUI.Color = .primary
        
        public init() {}
    }
}
