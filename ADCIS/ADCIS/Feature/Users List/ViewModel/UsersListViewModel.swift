//
//  UsersListViewModel.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import Foundation
import NetworkService
import StorageService

class UsersListViewModel: ObservableObject {
    @Published var error: Error?
    @Published var isAlertShowing = false
    var isProcessing = false

    var storageService: any StorageService
    var networkService: any NetworkService

    init(storageService: any StorageService, networkService: any NetworkService) {
        self.storageService = storageService
        self.networkService = networkService
    }

    init () {
        self.storageService = KeychainManager.shared
        self.networkService = LiveNetworkService.shared
    }

    @Published var users: [User] = []
    var currentPage: Int = 1
    var totalPages: Int = 1

    func getUsers() async {
        if isProcessing { return }
        isProcessing = true
        defer { isProcessing = false }

        do {
            let response = try await networkService.getUsersResponse(from: currentPage)
            await setUsers(response)
        } catch {
            setError(error)
        }
    }

    func logout() async {
        do {
            try await storageService.delete(forKey: StorageKeys.authToken)
            await MainActor.run {
                users = []
                currentPage = 1
                totalPages = 1
            }
        } catch {
            setError(error)
        }
    }

    func loadMoreIfNeeded(currentUser user: User) async {
        guard let last = users.last else { return }
        if last.id == user.id, currentPage < totalPages {
            currentPage += 1
            await getUsers()
        }
    }

    @MainActor
    private func setUsers(_ response: UsersResponse) {
        if response.page == 1 {
            users = response.data
        } else {
            users.append(contentsOf: response.data)
        }
        currentPage = response.page
        totalPages = response.totalPages
    }

    
    private func setError(_ error: Error) {
        Task { @MainActor in
            self.error = error
            self.isAlertShowing = true
        }
    }
}
