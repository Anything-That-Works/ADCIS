//
//  UserDetails.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import SwiftUI
import Domain

struct UserDetails: View {
    let user: User
    init(for user: User) {
        self.user = user
    }

    var body: some View {
        VStack {
            AsyncImage(url: user.avatar) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
            } placeholder: {
                ProgressView()
                    .frame(width: 200, height: 200)
            }
            VStack {
                Text(user.fullName)
                    .font(.title)
                Text(user.email)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    PushedPreview(.userDetails(user: User.demoUser))
}
