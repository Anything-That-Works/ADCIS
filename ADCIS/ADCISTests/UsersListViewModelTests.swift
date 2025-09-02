//
//  UsersListViewModelTests.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import XCTest
import NetworkService
import StorageService


final class UsersListViewModelTests: XCTestCase {
    var sut: UsersListViewModel!
    var storageService: KeychainManager!
    var networkService: MockNetworkService!

    override func setUpWithError() throws {
        networkService = MockNetworkService.shared
        storageService = KeychainManager.shared
        sut = UsersListViewModel(storageService: storageService, networkService: networkService)

        // Add a token so network requests succeed
        Task {
            try await storageService.save("MOCK_TOKEN", forKey: StorageKeys.authToken)
        }
    }

    override func tearDownWithError() throws {
        sut = nil
        Task {
            try await storageService.delete(forKey: StorageKeys.authToken)
        }
    }

    func testGetUsersLoadsFirstPage() async throws {
        await sut.getUsers()

        await MainActor.run {
            XCTAssertFalse(sut.users.isEmpty, "Expected users array to be non-empty after fetching first page.")
            XCTAssertEqual(sut.currentPage, 1, "Expected currentPage to be 1 after first fetch.")
            XCTAssertEqual(sut.totalPages, 2, "Expected totalPages to match mock response.")
            XCTAssertNil(sut.error, "Expected error to be nil after successful fetch.")
            XCTAssertFalse(sut.isAlertShowing, "Expected isAlertShowing to be false after successful fetch.")
        }
    }

    func testLoadMoreDoesNothingIfLastUserIsNotCurrent() async throws {
        await sut.getUsers()
        let initialCount = sut.users.count

        let fakeUser = User.demoUser
        await sut.loadMoreIfNeeded(currentUser: fakeUser)

        await MainActor.run {
            XCTAssertEqual(sut.users.count, initialCount, "Expected users count to remain the same if currentUser is not last user.")
            XCTAssertEqual(sut.currentPage, 1, "Expected currentPage to remain the same if loadMore not triggered.")
        }
    }

    func testLogoutClearsData() async throws {
        await sut.getUsers()
        XCTAssertFalse(sut.users.isEmpty, "Expected users array to have items before logout.")

        await sut.logout()

        await MainActor.run {
            XCTAssertTrue(sut.users.isEmpty, "Expected users array to be empty after logout.")
            XCTAssertEqual(sut.currentPage, 1, "Expected currentPage to reset to 1 after logout.")
            XCTAssertEqual(sut.totalPages, 1, "Expected totalPages to reset to 1 after logout.")
        }

        do {
            _ = try await storageService.load(String.self, forKey: StorageKeys.authToken)
            XCTFail("Expected loading deleted auth token to throw an error.")
        } catch {
            XCTAssertTrue(true, "Successfully failed to load deleted auth token.")
        }
    }

    func testSetErrorUpdatesErrorAndShowsAlert() async {
        let testError = NSError(domain: "TestError", code: 999, userInfo: nil)
        sut.setError(testError)

        // Small delay for Task { @MainActor } to run
        try? await Task.sleep(nanoseconds: 50_000_000)

        await MainActor.run {
            XCTAssertNotNil(sut.error, "Expected error to be set after calling setError.")
            XCTAssertTrue(sut.isAlertShowing, "Expected isAlertShowing to be true after calling setError.")
        }
    }

    func testGetUsersHandlesNetworkError() async throws {
        // Swap networkService with a failing mock
        class FailingMockNetworkService: NetworkService {
            func login(_ email: String, _ password: String) async throws -> String { "" }
            func getUsersResponse(from page: Int) async throws -> UsersResponse {
                throw NSError(domain: "NetworkError", code: 1)
            }
        }

        sut = UsersListViewModel(storageService: storageService, networkService: FailingMockNetworkService())

        await sut.getUsers()

        await MainActor.run {
            XCTAssertNotNil(sut.error, "Expected error to be set if network fails.")
            XCTAssertTrue(sut.isAlertShowing, "Expected alert to be shown if network fails.")
            XCTAssertTrue(sut.users.isEmpty, "Expected users to remain empty if network fails.")
        }
    }
}
