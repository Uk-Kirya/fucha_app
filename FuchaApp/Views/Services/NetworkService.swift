//
//  NetworkService.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 14.07.2026.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    private let authManager = AuthManager.shared
    // static let website_url = "http://127.0.0.1:8007"
    static let website_url = "https://fucha.losdesign.ru"
    
    private init() {}
    
    func request<T: Decodable>(
        _ endpoint: String,
        method: String = "GET",
        body: Encodable? = nil,
        retryCount: Int = 0
    ) async throws -> T {
        
        guard let url = URL(string: "\(NetworkService.website_url)/api/v1\(endpoint)") else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("ef3f905b509535db58bc6fb05cf8065646c32118cca8f99d7e51433e1e033c44", forHTTPHeaderField: "X-API-Key")
        
        // Add tokens
        if let access = authManager.accessToken {
            urlRequest.setValue("Bearer \(access)", forHTTPHeaderField: "Authorization")
        }
        
        if let refresh = authManager.refreshToken {
            urlRequest.setValue(refresh, forHTTPHeaderField: "X-Refresh-Token")
        }
        
        if let body = body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
        }
        
        // Check for new tokens in headers
        if let newAccess = httpResponse.allHeaderFields["X-Access-Token"] as? String,
           let newRefresh = httpResponse.allHeaderFields["X-Refresh-Token"] as? String {
            await MainActor.run {
                authManager.save(access: newAccess, refresh: newRefresh)
            }
        }
        
        // If unauthorized and we haven't retried yet, try to refresh
        if httpResponse.statusCode == 401 && retryCount == 0 {
            // Try to refresh tokens
            let refreshSuccess = await refreshTokens()
            
            if refreshSuccess {
                // Retry the original request with new tokens
                return try await self.request(endpoint, method: method, body: body, retryCount: 1)
            } else {
                // Refresh failed, logout user
                await MainActor.run {
                    authManager.logout()
                }
                throw NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Session expired. Please login again."])
            }
        }
        
        // Check other status codes
        guard httpResponse.statusCode == 200 else {
            let errorData = try? JSONDecoder().decode(APIError.self, from: data)
            let message = errorData?.errors.values.first ?? "Request failed with status \(httpResponse.statusCode)"
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
        }
        
        // Decode response
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response: \(error.localizedDescription)"])
        }
    }
    
    // MARK: - Logout
    
    func logout() async throws {
        // Отправляем запрос на logout с текущими токенами
        let _: EmptyResponse = try await self.request(
            "/auth/logout",
            method: "POST"
        )
        
        // После успешного logout очищаем локальные токены
        await MainActor.run {
            authManager.logout()
        }
    }
    
    // MARK: - Refresh Tokens
    
    private func refreshTokens() async -> Bool {
        guard let refreshToken = authManager.refreshToken else {
            return false
        }
        
        guard let url = URL(string: "\(NetworkService.website_url)/api/v1/auth/refresh") else {
            return false
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("ef3f905b509535db58bc6fb05cf8065646c32118cca8f99d7e51433e1e033c44", forHTTPHeaderField: "X-API-Key")
        request.setValue(refreshToken, forHTTPHeaderField: "X-Refresh-Token")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return false
            }
            
            // Check headers for new tokens
            if let newAccess = httpResponse.allHeaderFields["X-Access-Token"] as? String,
               let newRefresh = httpResponse.allHeaderFields["X-Refresh-Token"] as? String {
                await MainActor.run {
                    authManager.save(access: newAccess, refresh: newRefresh)
                }
                return true
            }
            
            // Or try to decode from body
            let result = try JSONDecoder().decode(TokenRefreshResponse.self, from: data)
            await MainActor.run {
                authManager.save(access: result.access_token, refresh: result.refresh_token)
            }
            return true
            
        } catch {
            return false
        }
    }
}

// MARK: - Response Models

struct TokenRefreshResponse: Decodable {
    let success: Bool
    let access_token: String
    let refresh_token: String
}

struct EmptyResponse: Decodable {}
