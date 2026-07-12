//
//  AuthManager.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 12.07.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AuthManager: ObservableObject {

    static let shared = AuthManager()

    @Published var isLoggedIn = false

    private init() {
        loadTokens()
    }

    func loadTokens() {
        let access = UserDefaults.standard.string(forKey: "access_token")
        let refresh = UserDefaults.standard.string(forKey: "refresh_token")

        isLoggedIn = access != nil && refresh != nil
    }

    func save(access: String, refresh: String) {

        UserDefaults.standard.set(access, forKey: "access_token")
        UserDefaults.standard.set(refresh, forKey: "refresh_token")

        isLoggedIn = true
    }

    func logout() {

        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")

        isLoggedIn = false
    }

    var accessToken: String? {
        UserDefaults.standard.string(forKey: "access_token")
    }

    var refreshToken: String? {
        UserDefaults.standard.string(forKey: "refresh_token")
    }
}
