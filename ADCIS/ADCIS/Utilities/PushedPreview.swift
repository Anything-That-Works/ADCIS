//
//  PushedPreview.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import SwiftUI
import WayFinder

struct PushedPreview: View {
    @StateObject private var wayFinder: WayFinder<AppRoute> = WayFinder(initial: .login)
    let route: AppRoute

    init(_ route: AppRoute) {
        self.route = route
    }

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
        }.onAppear {
            wayFinder.push(route)
        }
    }
}
