//
//  MainTabView.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 09.07.2026.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
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
                        title: "Мои планы",
                        icon: "sharedwithyou",
                        isSelected: selectedTab == 0,
                        action: { selectedTab = 0 }
                    )
                    
                    TabButton(
                        title: "Все планы",
                        icon: "target",
                        isSelected: selectedTab == 1,
                        action: { selectedTab = 1 }
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
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .ignoresSafeArea(edges: .top)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct TabButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(title)
                    .font(.system(size: 12))
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(isSelected ? Color(red: 150/255, green: 94/255, blue: 235/255) : Color.clear)
            .clipShape(Capsule())
        }
    }
}
