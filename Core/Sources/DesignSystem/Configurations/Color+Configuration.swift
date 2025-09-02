//
//  Color+Configuration.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import SwiftUI

public enum Color {}

public extension Color {
    struct Configuration {
        public var primary: SwiftUI.Color = .blue
        public var secondary: SwiftUI.Color = .orange
        public var background: SwiftUI.Color = .init(.systemBackground)
        
        public var text: SwiftUI.Color = .primary

        public var error: SwiftUI.Color = .red
        public var success: SwiftUI.Color = .green
        public var warning: SwiftUI.Color = .yellow
        
        public init() {}
    }
}
