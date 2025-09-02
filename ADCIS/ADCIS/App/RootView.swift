//
//  RootView.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import Domain
import SwiftUI
import WayFinder

enum AppRoute: Hashable {
    case login
    case usersList
    case userDetails(user: User)
}

struct RootView: View {
    @StateObject private var wayFinder = WayFinder<AppRoute>(initial: .login)
    var body: some View {
        WayFinderHost(wayFinder) { route in
            switch route {
            case .login:
                LoginView()
            case .usersList:
                UsersList()
            case .userDetails(let user):
                UserDetails(for: user)
            }
        }
    }
}

#Preview {
    RootView()
}
