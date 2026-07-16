//
//  HeaderView.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI

struct HeaderView: View {
    @State private var userManager = UserManager.shared
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color(.systemGray5))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "face.smiling")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Text(userManager.currentUser?.name ?? "Fucha")
                    .fontWeight(Font.Weight.bold)
                    .font(.system(size: 24))
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .padding(.top, 50)
        //.glassEffect(in: .rect(cornerRadius: 32.0))
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.systemBackground).opacity(1),
                    Color(.systemBackground).opacity(0.8),
                    Color(.systemBackground).opacity(0.6),
                    Color(.systemBackground).opacity(0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}


struct VisualEffectView: UIViewRepresentable {
    let effect: UIVisualEffect
    
    func makeUIView(context: UIViewRepresentableContext<VisualEffectView>) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: effect)
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<VisualEffectView>) {
        uiView.effect = effect
    }
}
