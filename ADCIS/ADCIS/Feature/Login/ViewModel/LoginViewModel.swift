//
//  LoginViewModel.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import Foundation
import NetworkService
import StorageService

class LoginViewModel: ObservableObject {
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

    func login(email: String, password: String) async {
        if isProcessing { return }
        isProcessing = true
        defer { isProcessing = false }
        
        do {
            let token = try await networkService.login(email, password)
            try await storageService.save(token, forKey: StorageKeys.authToken)
        } catch {
            setError(error)
        }
    }

    private func setError(_ error: Error) {
        Task { @MainActor in
            self.error = error
            self.isAlertShowing = true
        }
    }

    func clearError() {
        Task { @MainActor in
            self.error = nil
            self.isAlertShowing = false
        }
    }
}
