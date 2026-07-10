//
//  FuchaAppApp.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI
import SwiftData

@main
struct FuchaApp: App {
    
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                WelcomeView()
            } else {
                MainTabView()
                // WelcomeView()
            }
        }
    }
}
