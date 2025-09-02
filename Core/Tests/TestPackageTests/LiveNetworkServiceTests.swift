import XCTest
import Foundation
@testable import NetworkService
@testable import Domain

final class LiveNetworkServiceTests: XCTestCase {

    var service: (any NetworkService)!

    override func setUp() async throws {
        service = LiveNetworkService.shared
    }

    override func tearDown() async throws {
        service = nil
    }

    // MARK: - Login Tests

    func testLoginWithValidCredentials() async throws {
        let email = "eve.holt@reqres.in"
        let password = "cityslicka"

        let token = try await service.login(email, password)

        XCTAssertFalse(token.isEmpty, "Token should not be empty")
        XCTAssertTrue(token.count > 10, "Token should have reasonable length")
    }

    func testLoginWithInvalidCredentials() async throws {
        let email = "invalid@email.com"
        let password = "wrongpassword"

        do {
            _ = try await service.login(email, password)
            XCTFail("Login should have failed with invalid credentials")
        } catch {
            XCTAssertTrue(true, "Login correctly failed with invalid credentials")
        }
    }

    func testLoginWithEmptyEmail() async throws {
        let email = ""
        let password = "somepassword"

        do {
            _ = try await service.login(email, password)
            XCTFail("Login should have failed with empty email")
        } catch {
            XCTAssertTrue(true, "Login correctly failed with empty email")
        }
    }

    func testLoginWithEmptyPassword() async throws {
        let email = "test@example.com"
        let password = ""

        do {
            _ = try await service.login(email, password)
            XCTFail("Login should have failed with empty password")
        } catch {
            XCTAssertTrue(true, "Login correctly failed with empty password")
        }
    }

    func testLoginWithMalformedEmail() async throws {
        let email = "notanemail"
        let password = "somepassword"

        do {
            _ = try await service.login(email, password)
            XCTFail("Login should have failed with malformed email")
        } catch {
            XCTAssertTrue(true, "Login correctly failed with malformed email")
        }
    }

    // MARK: - Get Users Tests
    func testGetUsersZeroPage() async throws {
        let page = 0

        let usersResponse = try await service.getUsersResponse(from: page)

        XCTAssertEqual(usersResponse.page, 1, "Response page should match requested page")
        XCTAssertGreaterThanOrEqual(usersResponse.data.count, 0, "Should have users or empty array")
        XCTAssertGreaterThan(usersResponse.totalPages, 0, "Should have total pages")
        XCTAssertGreaterThan(usersResponse.total, 0, "Should have total count")
    }

    func testGetUsersFirstPage() async throws {
        let page = 1

        let usersResponse = try await service.getUsersResponse(from: page)

        XCTAssertEqual(usersResponse.page, page, "Response page should match requested page")
        XCTAssertGreaterThanOrEqual(usersResponse.data.count, 0, "Should have users or empty array")
        XCTAssertGreaterThan(usersResponse.totalPages, 0, "Should have total pages")
        XCTAssertGreaterThan(usersResponse.total, 0, "Should have total count")
    }

    func testGetUsersSecondPage() async throws {
        let page = 2

        let usersResponse = try await service.getUsersResponse(from: page)

        XCTAssertEqual(usersResponse.page, page, "Response page should match requested page")
        XCTAssertGreaterThanOrEqual(usersResponse.data.count, 0, "Should have users or empty array")
        XCTAssertGreaterThan(usersResponse.totalPages, 0, "Should have total pages")
        XCTAssertGreaterThan(usersResponse.total, 0, "Should have total count")
    }

    func testGetUsersBeyondTotalPages() async throws {
        let page = 9999

        let usersResponse = try await service.getUsersResponse(from: page)

        XCTAssertEqual(usersResponse.page, page, "Response page should match requested page")
        XCTAssertEqual(usersResponse.data.count, 0, "Excessive page number correctly returned with no data")
    }

    // MARK: - Singleton Tests
    func testSingletonBehavior() {
        let instance1 = LiveNetworkService.shared
        let instance2 = LiveNetworkService.shared

        XCTAssertTrue(instance1 === instance2, "Should return the same singleton instance")
    }
}
