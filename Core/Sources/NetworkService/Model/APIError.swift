//
//  APIError.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidResponse
    case conflict(message: String)

    var errorDescription: String? {
        switch self {
        case .conflict(let message):
            return message
        case .invalidResponse:
            return "Request could not be processed. Please try again later."
        }
    }
}
