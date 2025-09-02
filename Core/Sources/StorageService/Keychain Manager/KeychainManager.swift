//
//  KeychainError.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import Foundation

public final class KeychainManager: StorageService {
    public static let shared = KeychainManager()
    
    private init() {}
    
    public func save<T>(_ item: T, forKey key: String) async throws where T: Decodable & Encodable {
        let service: String = Bundle.main.bundleIdentifier ?? "DefaultService"
        
        do {
            let data = try JSONEncoder().encode(item)
            try await delete(forKey: key)
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            guard status == errSecSuccess else {
                print("❌ Failed to save Codable item to Keychain for key '\(key)': OSStatus \(status)")
                throw KeychainError.unexpectedStatus(status)
            }
            print("✅ Successfully saved Codable item to Keychain for key '\(key)': \(item)")
        } catch {
            print("❌ Failed to encode item for Keychain key '\(key)':", error)
            throw error
        }
    }
    
    public func load<T>(
        _ type: T.Type,
        forKey key: String
    ) async throws -> T? where T: Decodable & Encodable {
        let service: String = Bundle.main.bundleIdentifier ?? "DefaultService"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                print("⚠️ No data found in Keychain for key '\(key)'")
                throw KeychainError.itemNotFound
            } else {
                print("❌ Failed to retrieve item from Keychain for key '\(key)': OSStatus \(status)")
                throw KeychainError.unexpectedStatus(status)
            }
        }
        
        guard let data = item as? Data else {
            print("❌ Invalid data retrieved from Keychain for key '\(key)'")
            throw KeychainError.invalidData
        }
        
        do {
            let result = try JSONDecoder().decode(type, from: data)
            print("✅ Successfully loaded Codable item from Keychain for key '\(key)': \(result)")
            return result
        } catch {
            print("❌ Failed to decode item from Keychain for key '\(key)':", error)
            throw KeychainError.invalidData
        }
    }
    
    public func delete(forKey key: String) async throws {
        let service: String = Bundle.main.bundleIdentifier ?? "DefaultService"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess || status == errSecItemNotFound {
            print("🗑️ Deleted value from Keychain for key '\(key)'")
        } else {
            print("❌ Failed to delete item from Keychain for key '\(key)': OSStatus \(status)")
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    public func exists(forKey key: String) async -> Bool {
        let service: String = Bundle.main.bundleIdentifier ?? "DefaultService"
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanFalse!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        let exists = status == errSecSuccess
        print(exists
              ? "✅ Value exists in Keychain for key '\(key)'"
              : "⚠️ Value does not exist in Keychain for key '\(key)'")
        return exists
    }
}
