//
//  LiveNetworkService.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import Domain
import Foundation

public actor LiveNetworkService: NetworkService {
    public static let shared = LiveNetworkService()
    
    private init() {}
    
    public func login(_ email: String, _ password: String) async throws -> String {
        let url = NetworkRoutes.loginURL
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        
        let payload: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        let result = await URLRequestHelper.makeAPIRequest(using: request)
        
        switch result {
        case .success(let data):
            let response = try LoginResponse.decode(from: data)
            return response.token
        case .failure(let error):
            throw error
        }
    }
    
    public func getUsersResponse(from page: Int) async throws -> UsersResponse  {
        let url = NetworkRoutes.getUsersURL(page: page)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        
        let result = await URLRequestHelper.makeAPIRequest(using: request)
        
        switch result {
        case .success(let data):
            let usersResponse = try UsersResponse.decode(from: data)
            return usersResponse
        case .failure(let error):
            throw error
        }
    }
}
