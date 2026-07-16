//
//  MainTabView.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 09.07.2026.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    private func playHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }

    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // Контент
            if selectedTab == 0 {
                MyChallenges()
            } else if selectedTab == 1 {
                AllChallenges()
            }
            
            // Фиксированный хедер (сверху)
            VStack {
                
                HeaderView()
                
                Spacer()
                
            }
                
            // Фиксированный таб-бар (снизу)
            HStack {
                HStack(spacing: 0) {
                    TabButton(
                        title: "Главная",
                        icon: "home",
                        isSelected: selectedTab == 0,
                        action: {
                            selectedTab = 0
                            playHaptic()
                        }
                    )
                    
                    TabButton(
                        title: "Челленджи",
                        icon: "target",
                        isSelected: selectedTab == 1,
                        action: {
                            selectedTab = 1
                            playHaptic()
                        }
                    )
                }
                .padding(4)
                .glassEffect()
                
                Spacer()
                
                Button {
                    // Действие
                } label: {
                    Circle()
                        .fill(Color(red: 150/255, green: 94/255, blue: 235/255))
                        .frame(width: 56, height: 56)
                        .overlay {
                            Image(systemName: "plus")
                                .foregroundStyle(.white)
                                .font(.title2)
                        }
                        .glassEffect()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground).opacity(1),
                        Color(.systemBackground).opacity(0)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
        }
        .ignoresSafeArea(edges: [.top, .bottom])
    }
}

struct TabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    private var backgroundActiveTabColor: Color {
        colorScheme == .dark ? Color(red:51/255, green:51/255, blue:51/255) : Color(red:239/255, green:239/255, blue:239/255)
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primary)
                Text(title)
                    .font(.system(size: 12))
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(isSelected ? backgroundActiveTabColor : Color.clear)
            .clipShape(Capsule())
        }
    }
}
