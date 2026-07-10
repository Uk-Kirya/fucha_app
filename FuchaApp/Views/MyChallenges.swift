//
//  MyChallenges.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI

struct MyChallenges: View {
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(1...20, id: \.self) { index in
                        HStack {
                            Image("img1")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text("Challenge \(index)")
                                .font(.headline)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.top, 130)
                .padding(.bottom, 20)
                
                Button {

                    NotificationManager.shared.requestPermission()

                    NotificationManager.shared.sendTestNotification()


                } label: {

                    Text("Запустить уведомление")
                        .padding()
                        .glassEffect()

                }
                
                Spacer()
                    .frame(height: 150)
            }
            .scrollIndicators(.hidden)
        }
        .background(Color(.systemGroupedBackground))
    }
}
