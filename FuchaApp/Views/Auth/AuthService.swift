//
//  AuthService.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 12.07.2026.
//

import Foundation

final class AuthService {

    static let shared = AuthService()

    func login(
        email: String,
        password: String
    ) async throws {

        guard let url = URL(string: "https://fucha.losdesign.ru/api/v1/auth/login") else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("ef3f905b509535db58bc6fb05cf8065646c32118cca8f99d7e51433e1e033c44", forHTTPHeaderField: "X-API-Key")

        request.httpBody = try JSONEncoder().encode(
            LoginRequest(
                email: email,
                password: password
            )
        )

        let (data,response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            return
        }

        if http.statusCode == 200 {

            let result = try JSONDecoder().decode(
                LoginResponse.self,
                from: data
            )

            await MainActor.run {

                AuthManager.shared.save(
                    access: result.access_token,
                    refresh: result.refresh_token
                )

            }

        } else {

            let error = try JSONDecoder().decode(
                APIError.self,
                from: data
            )

            throw NSError(
                domain: "",
                code: http.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:error.errors.values.first ?? "Ошибка"
                ]
            )

        }

    }

}
