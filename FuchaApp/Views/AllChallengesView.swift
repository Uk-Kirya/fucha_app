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
    @StateObject private var authManager = AuthManager.shared
    
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
                    
                    Button("Повторить") {
                        fetchData()
                    }
                    .padding()
                    .glassEffect()
                }
            } else {
                Text(responseData)
                
                Button {
                    Task {
                        await performLogout()
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
        
        Task {
            do {
                let response: User = try await NetworkService.shared.request("/auth/test")
                await MainActor.run {
                    let user = response
                    responseData = "User: \(user.name) (\(user.email))"
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }
    
    @MainActor
    func logout() async {
        authManager.logout()
    }
    
    @MainActor
    func performLogout() async {
        do {
            try await NetworkService.shared.logout()
            // После успешного выхода, токены уже очищены в NetworkService.logout()
            // Можно добавить навигацию на экран входа
        } catch {
            // Если logout на сервере не удался, все равно очищаем локальные токены
            authManager.logout()
            print("Logout error: \(error.localizedDescription)")
        }
    }
}
