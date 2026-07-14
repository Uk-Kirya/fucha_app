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
                
        VStack {
            
            Image("start__image")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(spacing:12) {
                VStack {
                    
                    Text("Создавай планы.")
                        .font(.system(size:30, weight:.bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Проходи челленджи.")
                        .font(.system(size:30, weight:.bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Достигай большего.")
                        .font(.system(size:30, weight:.bold))
                        .multilineTextAlignment(.center)
                    
                }
                
                Text("От спорта и путешествий до новых навыков и привычек — создавай личные планы, проходи челленджи сообщества и наблюдай за своим прогрессом")
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
            
        }
        
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
