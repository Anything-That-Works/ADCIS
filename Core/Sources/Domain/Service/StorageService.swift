//
//  StorageService.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

public protocol StorageService: AnyObject, Sendable {
    func save<T: Codable>(_ item: T, forKey key: String) async throws
    func load<T: Codable>(_ type: T.Type, forKey key: String) async throws -> T?
    func delete(forKey key: String) async throws
    func exists(forKey key: String) async -> Bool
}
