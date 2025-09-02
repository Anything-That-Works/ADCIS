//
//  UsersList.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import SwiftUI
import WayFinder

struct UsersList: View {
    @EnvironmentObject private var wayFinder: WayFinder<AppRoute>
    @StateObject private var viewModel = UsersListViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.users) { user in
                    UsersListRowView(user)
                        .onTapGesture {
                            wayFinder.push(.userDetails(user: user))
                        }
                        .task {
                            await viewModel.loadMoreIfNeeded(currentUser: user)
                        }
                }
            }
        }
        .task {
            await viewModel.getUsers()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Log Out", role: .destructive) {
                    Task {
                        await viewModel.logout()
                        wayFinder.popToRoot()
                    }
                }
            }
        }
        .alert("Sorry", isPresented: $viewModel.isAlertShowing, actions: {
            Button("Ok", role: .cancel) { }
        }, message: {
            if let message = viewModel.error?.localizedDescription {
                Text(message)
            }
        })
    }
}


#Preview {
    PushedPreview(.usersList)
}
