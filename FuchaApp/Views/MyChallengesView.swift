//
//  MyChallengesView.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI

struct MyChallenges: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack(spacing: 0) {
            ScrollView {
                
                Spacer()
                    .frame(height: 120)
                
                VStack(spacing: 24) {
                    ForEach(1...5, id: \.self) { index in
                        HStack(alignment: .top, spacing: 12) {
                            
                            // Картинка
                            Image("img1")
                                .resizable()
                                .frame(width: 100, height: 148)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            // Текст
                            VStack(spacing: 0) {
                                
                                // Заголовок | More | Описание | Теги
                                VStack(alignment: .leading, spacing: 0) {
                                    
                                    // Заголовок | More
                                    HStack(alignment: .top, spacing: 0) {
                                        
                                        // Заголовок
                                        Text("Готовлюсь к веломарафону")
                                            .font(.title3)
                                            .bold()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(minHeight: 0, maxHeight: 50)
                                            .padding(.trailing, 8)
                                        
                                        // More
                                        Image("more")
                                    }
                                    .fixedSize(horizontal: false, vertical: true)
                                    
                                    // Описание
                                    HStack {
                                        Text("В нашем курсе вы научитесь строить композицию основываясь на")
                                            .font(.system(size: 14))
                                            .foregroundColor(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(minHeight: 0, maxHeight: 50)
                                    }
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.top, 4)
                                    
                                    // Теги
                                    HStack(spacing: 4) {
                                        Text("@nickname")
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color(red:51/255, green:51/255, blue:51/255))
                                            .clipShape(Capsule())
                                            .foregroundColor(.white)
                                            .font(.caption)
                                        
                                        Text("Спорт")
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color(red:150/255, green:94/255, blue:235/255))
                                            .clipShape(Capsule())
                                            .foregroundColor(.white)
                                            .font(.caption)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 8)
                                    .fixedSize(horizontal: false, vertical: true)
                                }
                                
                                Spacer()
                                
                                // Статус-бар
                                VStack(alignment: .leading) {
                                    
                                    // Индикатор состояния
                                    VStack {
                                        VStack {}
                                            .frame(width: 20, height: 6)
                                            .background(Color(red:150/255, green:94/255, blue:235/255))
                                            .clipShape(Capsule())
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 6)
                                    .background(colorScheme == .dark ? .gray.opacity(0.2) : .gray.opacity(0.1))
                                    .clipShape(Capsule())
                                    
                                    // Цифры с индикатора
                                    HStack(spacing: 0) {
                                        Text("123")
                                            .foregroundColor(Color(red:150/255, green:94/255, blue:235/255))
                                            .bold()
                                        Text(" из 231")
                                            .foregroundColor(Color(.systemGray))
                                    }
                                    .font(.system(size: 12))
                                    .fontWeight(.medium)
                                }
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                        }
                        .padding(.horizontal, 16)
                    }
                }
                
                Spacer()
                    .frame(height: 24)
                
                Button {

                    NotificationManager.shared.requestPermission()

                    NotificationManager.shared.sendTestNotification()


                } label: {

                    Text("Запустить уведомление")
                        .padding()
                        .glassEffect()

                }
                
                Spacer()
                    .frame(height: 110)
            }
            .scrollIndicators(.hidden)
        }
        .background(Color(.systemBackground))
    }
}
