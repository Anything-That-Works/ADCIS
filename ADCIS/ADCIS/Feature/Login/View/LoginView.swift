//
//  LoginView.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import SwiftUI
import WayFinder

struct LoginView: View {
    @Environment(\.configuration) private var config
    @EnvironmentObject private var wayFinder: WayFinder<AppRoute>

    @StateObject private var viewModel = LoginViewModel()

    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack(spacing: 20) {
            InputField(
                icon: config.icons.email,
                placeholder: "Enter your email",
                text: $email,
                keyboardType: .emailAddress
            )

            InputField(
                icon: config.icons.password,
                placeholder: "Enter your password",
                text: $password,
                isSecure: true
            )

            Button("Login", action: login)
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isProcessing || !isFormValid)
        }
        .padding()
        .alert("Sorry!!!", isPresented: $viewModel.isAlertShowing, actions: {
            Button("Ok", role: .cancel, action: viewModel.clearError)
            Button("Try Again", action: login)
        }, message: {
            if let message = viewModel.error?.localizedDescription {
                Text(message)
            }
        })
    }

    private func login() {
        Task {
            await viewModel.login(email: email, password: password)
            if viewModel.error == nil {
                wayFinder.push(.usersList)
            } else {
                viewModel.isAlertShowing = true
            }
        }
    }

    private var isFormValid: Bool {
        !password.isEmpty &&
        isValidEmail(email)
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        return email.range(of: emailRegex, options: .regularExpression) != nil
    }
}

#Preview {
    LoginView()
}
