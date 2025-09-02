//
//  LoginResponse.swift
//  Core
//
//  Created by Promal on 2/9/25.
//


import Foundation

struct LoginResponse: Decodable {
    let token: String
}

extension LoginResponse {
    static func decode(from data: Data) throws -> LoginResponse {
        let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
        return decoded
    }
}
