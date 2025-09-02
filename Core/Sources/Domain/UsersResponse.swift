//
//  UsersResponse.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import Foundation

public struct UsersResponse: Codable, Sendable {
    public let page: Int
    public let perPage: Int
    public let total: Int
    public let totalPages: Int
    public let data: [User]
    public let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
        case support
    }
}

public struct Support: Codable, Sendable {
    public let url: URL
    public let text: String
}

public extension UsersResponse {
    static func decode(from data: Data) throws -> UsersResponse {
        let response = try JSONDecoder().decode(UsersResponse.self, from: data)
        return response
    }
}
