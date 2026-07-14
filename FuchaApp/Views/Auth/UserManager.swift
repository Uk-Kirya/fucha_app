//
//  UserManager.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 14.07.2026.
//

import Foundation
import Observation

@Observable
final class UserManager {

    static let shared = UserManager()

    var currentUser: User?

    private init() {}

    @MainActor
    func loadProfile() async {

        do {

            let user: User =
                try await NetworkService.shared.request(
                    "/auth/me"
                )

            currentUser = user

        } catch {

            print(error)

        }

    }

    @MainActor
    func logout() {
        currentUser = nil
    }

}
