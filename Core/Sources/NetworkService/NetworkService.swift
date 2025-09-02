//
//  NetworkService.swift
//  Core
//
//  Created by Promal on 2/9/25.
//
//

@_exported import Domain

import Domain

public protocol NetworkService: AnyObject {
    func login(_ email: String,_ password: String) async throws -> String

    func getUsersResponse(from page: Int) async throws -> UsersResponse
}
