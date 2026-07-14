//
//  AuthService.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 12.07.2026.
//

import Foundation

final class AuthService {
    
    static let shared = AuthService()
    private let authManager = AuthManager.shared
    
    func login(email: String, password: String) async throws {
        let request = LoginRequest(email: email, password: password)
        
        do {
            let response: LoginResponse = try await NetworkService.shared.request(
                "/auth/login",
                method: "POST",
                body: request
            )
            
            await MainActor.run {
                authManager.save(
                    access: response.access_token,
                    refresh: response.refresh_token
                )
            }
        } catch {
            throw error
        }
    }
}
