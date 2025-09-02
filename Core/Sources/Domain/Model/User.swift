//
//  User.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import Foundation

public struct User: Codable, Identifiable, Hashable, Sendable {
    public let id: Int
    public let email: String
    public let firstName: String
    public let lastName: String
    public let avatar: URL

    public var fullName: String {
        "\(firstName) \(lastName)"
    }

    public init(id: Int, email: String, firstName: String, lastName: String, avatar: URL) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName  = "last_name"
        case avatar
    }
}

public extension User {
    static func decode(from data: Data) throws -> User {
        return try JSONDecoder().decode(User.self, from: data)
    }
}
