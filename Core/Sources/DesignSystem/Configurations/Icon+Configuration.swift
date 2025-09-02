//
//  Icon+Configuration.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

public enum Icon {}

public extension Icon {
    struct Configuration {
        public var success: String = "checkmark.circle.fill"
        public var error: String = "xmark.octagon.fill"
        public var warning: String = "exclamationmark.triangle.fill"

        public var email: String = "envelope"
        public var password: String = "lock"

        public init() {}
    }
}
