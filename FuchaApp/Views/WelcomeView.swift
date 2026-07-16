//
//  ContentView.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI

struct WelcomeView: View {

    @State private var showLogin = false
    @State private var triggerHaptic = false
    
    @State private var imageScale = 0.5
    @State private var imageRotation = -15.0
    @State private var imageOpacity = 0.0
    
    private func playHapticPattern() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        
        var count = 0
        let maxCount = 15
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            generator.impactOccurred()
            count += 1
            
            if count >= maxCount {
                timer.invalidate()
            }
        }
    }

    var body: some View {
                
        VStack {
            
            Image("start__image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(imageScale)
                .rotationEffect(.degrees(imageRotation))
                .opacity(imageOpacity)
                .onAppear {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.4, blendDuration: 0)) {
                        imageScale = 1.0
                        imageRotation = 0
                        imageOpacity = 1.0
                    }
                }
            
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
        .onAppear {
            playHapticPattern()
        }
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.3), trigger: triggerHaptic)
        
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
