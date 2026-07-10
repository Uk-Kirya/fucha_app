//
//  ContentView.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI

struct WelcomeView: View {

    @State private var showLogin = false

    var body: some View {
                
        VStack(spacing:12) {
            
            Image("fucha_start")
                .padding(.bottom, 50)
            
            Text("Создайте бесплатный аккаунт или войдите в существующий")
                .font(.system(size:22, weight:.bold))
                .multilineTextAlignment(.center)
            
            Text("Создавайте планы и челленджи или участвуйте в челленджах сообщества.")
                .font(.system(size:15))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
            
            Button {
                
                showLogin = true
                
            } label: {
                
                Text("Войти или создать аккаунт")
                    .foregroundStyle(.white)
                    .frame(maxWidth:.infinity)
                    .frame(height:56)
                    .background(
                        Color(
                            red:150/255,
                            green:94/255,
                            blue:235/255
                        )
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius:16
                        )
                    )
                
            }
            
        }
        .padding(.horizontal)
        
        .sheet(isPresented: $showLogin) {
            LoginView()
                .presentationDetents([.height(665)])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color(.systemBackground))
        }
    }

}

#Preview {

    WelcomeView()

}
