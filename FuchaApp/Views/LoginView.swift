//
//  LoginView.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    
    @Environment(\.dismiss) private var dismiss


    var body: some View {

        VStack(spacing:0) {

            ZStack(alignment:.topLeading) {


                VStack(spacing:0) {


                    Image("bg__1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 32
                            )
                        )

                    Spacer()

                }


                Button {
                    
                    dismiss()
                    
                } label: {

                    Image(systemName: "xmark")
                        .foregroundStyle(Color(.label))
                        .frame(width:44,height:44)
                        .glassEffect()

                }
                .padding(.leading,16)
                .padding(.top,16)


            }


            VStack(alignment:.leading,spacing:0) {


                Image("fucha_2")
                    .resizable()
                    .scaledToFit()
                    .frame(width:130)


                Text("Войдите или создайте бесплатный аккаунт")
                    .font(
                        .system(
                            size:30,
                            weight:.bold
                        )
                    )
                    .lineSpacing(2)
                    .padding(.top,16)
                    .padding(.bottom,12)
                    .fixedSize(horizontal: false, vertical: true)



                CustomTextField(
                    title:"Электронная почта",
                    text:$email,
                    isPassword:false
                )


                CustomTextField(
                    title:"Пароль",
                    text:$password,
                    isPassword:true,
                    showPassword:$showPassword
                )


            }
            .padding(.horizontal,16)


            VStack(spacing:6) {


                Button {
                    Task {

                            do {

                                try await AuthService.shared.login(
                                    email: email,
                                    password: password
                                )

                                dismiss()

                            } catch {

                                print(error.localizedDescription)

                            }

                        }

                } label: {

                    Text("Продолжить")
                        .foregroundStyle(.white)
                        .font(.system(size:15,weight:.medium))
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


                Button {

                } label: {

                    Text("Восстановить пароль")
                        .foregroundStyle(.gray)
                        .frame(height:40)

                }


                VStack(spacing: 0) {
                    Text("Продолжая, вы соглашаетесь с ")
                        .font(.system(size: 13))
                        .foregroundStyle(Color(.systemGray2)    )
                    
                    Text("Условиями использования Fucha")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 150/255, green: 94/255, blue: 235/255))
                        .underline()
                        .onTapGesture {
                            // Открыть ссылку
                            if let url = URL(string: "https://fucha.app/terms") {
                                UIApplication.shared.open(url)
                            }
                        }
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            }
            .padding(.horizontal,16)

        }
        .ignoresSafeArea(edges:.top)

    }

}

#Preview {

    WelcomeView()

}
