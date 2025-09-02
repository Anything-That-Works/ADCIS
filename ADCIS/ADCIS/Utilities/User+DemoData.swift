//
//  User+DemoData.swift
//  ADCIS
//
//  Created by Promal on 2/9/25.
//

import Domain
import Foundation

extension User {
    static let demoUser: User = User(
        id: 1,
        email: "george.bluth@reqres.in",
        firstName: "George",
        lastName: "Bluth",
        avatar: URL(string: "https://reqres.in/img/faces/1-image.jpg")!
    )

    static let demoUsers: [User] = [
        User(
            id: 1,
            email: "george.bluth@reqres.in",
            firstName: "George",
            lastName: "Bluth",
            avatar: URL(string: "https://reqres.in/img/faces/1-image.jpg")!
        ),
        User(
            id: 2,
            email: "janet.weaver@reqres.in",
            firstName: "Janet",
            lastName: "Weaver",
            avatar: URL(string: "https://reqres.in/img/faces/2-image.jpg")!
        ),
        User(
            id: 3,
            email: "emma.wong@reqres.in",
            firstName: "Emma",
            lastName: "Wong",
            avatar: URL(string: "https://reqres.in/img/faces/3-image.jpg")!
        ),
        User(
            id: 4,
            email: "eve.holt@reqres.in",
            firstName: "Eve",
            lastName: "Holt",
            avatar: URL(string: "https://reqres.in/img/faces/4-image.jpg")!
        ),
        User(
            id: 5,
            email: "charles.morris@reqres.in",
            firstName: "Charles",
            lastName: "Morris",
            avatar: URL(string: "https://reqres.in/img/faces/5-image.jpg")!
        ),
        User(
            id: 6,
            email: "tracey.ramos@reqres.in",
            firstName: "Tracey",
            lastName: "Ramos",
            avatar: URL(string: "https://reqres.in/img/faces/6-image.jpg")!
        )
    ]
}
