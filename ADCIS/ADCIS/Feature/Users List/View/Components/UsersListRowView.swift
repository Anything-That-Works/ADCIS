//
//  UsersListRowView.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import SwiftUI
import Domain

struct UsersListRowView: View {
    let user: User
    @Environment(\.configuration) private var config

    init(_ user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: user.avatar) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
            } placeholder: {
                ProgressView()
                    .frame(width: 40, height: 40)
            }
            VStack(alignment: .leading) {
                Text(user.fullName)
                    .font(.headline)
                Text(user.email)
                    .font(.caption)
            }
            .foregroundStyle(config.colors.text)
        }
    }
}
