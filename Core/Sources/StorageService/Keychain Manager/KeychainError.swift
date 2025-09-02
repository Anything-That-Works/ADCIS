//
//  KeychainError.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import Foundation

public enum KeychainError: Error {
    case duplicateItem
    case itemNotFound
    case invalidData
    case unexpectedStatus(OSStatus)
}
