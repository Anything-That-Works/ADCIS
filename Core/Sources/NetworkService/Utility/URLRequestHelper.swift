//
//  URLRequestHelper.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import Foundation

public class URLRequestHelper {
    private init() {}

    public static func makeAPIRequest(using request: URLRequest) async -> Result<Data, Error> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(APIError.invalidResponse)
            }

            let statusCode = httpResponse.statusCode

            if (200...299).contains(statusCode) {
                return .success(data)
            } else {
                let errorMessage = try ErrorResponse.decode(from: data).error
                return .failure(APIError.conflict(message: errorMessage))
            }
        } catch {
            return .failure(error)
        }
    }
}
