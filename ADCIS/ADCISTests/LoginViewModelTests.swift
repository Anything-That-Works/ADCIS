//
//  LoginViewModelTests.swift
//  ADCISTests
//
//  Created by Promal on 2/9/25.
//

import XCTest
import NetworkService
import StorageService

final class LoginViewModelTests: XCTestCase {
    var sut: LoginViewModel!
    var storageService: KeychainManager!
    var networkService: MockNetworkService!

    override func setUpWithError() throws {
        networkService = MockNetworkService.shared
        storageService = KeychainManager.shared
        sut = LoginViewModel(storageService: storageService, networkService: networkService)
    }

    override func tearDownWithError() throws {
        sut = nil
        Task {
            try await storageService.delete(forKey: StorageKeys.authToken)
        }
    }

    func testSettingError() async {
        sut.setError(URLError(.badServerResponse))

        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertNotNil(sut.error)
        XCTAssertEqual(sut.isAlertShowing, true)
    }

    func testLoginSuccessSavesToken() async throws {
        // Use valid test credentials
        await sut.login(email: "eve.holt@reqres.in", password: "cityslicka")

        let savedToken: String? = try await storageService.load(String.self, forKey: StorageKeys.authToken)
        XCTAssertEqual(savedToken, "QpwL5tke4Pnpja7X4")
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.isAlertShowing)
    }


    func testClearErrorResetsProperties() async {
        sut.error = NSError(domain: "", code: 0)
        sut.isAlertShowing = true

        sut.clearError()

        try? await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.isAlertShowing)
    }
}
