//
//  NetworkRoutes.swift
//  Core
//
//  Created by Promal on 2/9/25.
//

import Foundation

struct NetworkRoutes {
    private init() {}
    
    static let baseURL: URL = URL(string: "https://reqres.in/api")!
    static let loginPath: String = "/login"
    static let usersPath: String = "/users"
    
    static var loginURL: URL { baseURL.appendingPathComponent(loginPath) }
    
    static func getUsersURL(page: Int) -> URL {
        let url = baseURL.appendingPathComponent(usersPath)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        return components?.url ?? url
    }
}
