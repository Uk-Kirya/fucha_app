//
//  Start.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI
import SwiftData

@main
struct Start: App {

    @StateObject var auth = AuthManager.shared

    var body: some Scene {

        WindowGroup {

            if auth.isLoggedIn {

                MainTabView()

            } else {

                WelcomeView()

            }

        }

    }

}
