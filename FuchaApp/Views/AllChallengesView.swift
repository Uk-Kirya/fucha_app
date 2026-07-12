//
//  AllChallenges.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI

struct AllChallenges: View {
    @State private var responseData: String = "Загрузка..."
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Spacer()
            
            if isLoading {
                ProgressView("Загрузка...")
                    .padding()
            } else if let error = errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("❌ \(error)")
                        .foregroundColor(.red)
                        .padding()
                        .multilineTextAlignment(.center)
                }
            } else {
                Text(responseData)
                
                Button {
                    Task {
                        await logout()
                    }
                } label: {
                    Text("Выйти")
                        .padding()
                        .glassEffect()
                }
                
            }
            
            Spacer()
        }
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        isLoading = true
        errorMessage = nil
        responseData = "Загрузка..."
        
        guard let url = URL(string: "https://fucha.losdesign.ru/api/v1/test") else {
            errorMessage = "Неверный URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("ef3f905b509535db58bc6fb05cf8065646c32118cca8f99d7e51433e1e033c44", forHTTPHeaderField: "X-API-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = "Ошибка соединения: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    errorMessage = "Нет данных от сервера"
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(UserResponse.self, from: data)
                    let user = response.data
                    
                    responseData = "User: \(user.name) (\(user.email))"
                    
                } catch {
                    let rawString = String(data: data, encoding: .utf8) ?? "Нет данных"
                    errorMessage = "Ошибка парсинга JSON: \(error.localizedDescription)"
                    responseData = "Сырой ответ:\n\(rawString)"
                }
            }
        }.resume()
    }
}


func logout() async {

    guard let access = AuthManager.shared.accessToken,
          let refresh = AuthManager.shared.refreshToken
    else {
        return
    }


    var request = URLRequest(
        url: URL(
            string: "https://fucha.losdesign.ru/api/v1/auth/logout"
        )!
    )


    request.httpMethod = "POST"


    request.setValue(
        "Bearer \(access)",
        forHTTPHeaderField: "Authorization"
    )


    request.setValue(
        refresh,
        forHTTPHeaderField: "X-Refresh-Token"
    )


    do {

        let _ = try await URLSession.shared.data(
            for: request
        )

    } catch {

        print(error.localizedDescription)

    }


    await MainActor.run {

        AuthManager.shared.logout()

    }
}
