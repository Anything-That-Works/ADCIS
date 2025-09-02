//
//  ErrorResponse.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import Foundation

struct ErrorResponse: Decodable {
    let error: String
}

extension ErrorResponse {
    static func decode(from data: Data) throws -> ErrorResponse {
        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,from: data)
        return errorResponse
    }
}
