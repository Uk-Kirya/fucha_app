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
    @State private var emailError: String?
    @State private var passwordError: String?
    
    @FocusState private var focusedField: Field?
    
    @Environment(\.dismiss) private var dismiss
    
    private var isLoginValid: Bool {

        let emailValid =
            isValidEmail(
                email.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
            )

        let passwordValid =
            password.count >= 1

        return emailValid && passwordValid
    }
    
    enum Field {
        case email
        case password
    }
    
    private func validateEmail() {

        let email = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if email.isEmpty {

            emailError = "Введите электронную почту"

        } else if !isValidEmail(email) {

            emailError = "Введите корректный E-mail"

        } else {

            emailError = nil
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {

        let emailRegex =
        "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        return NSPredicate(
            format: "SELF MATCHES %@",
            emailRegex
        )
        .evaluate(
            with: email
        )
    }


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
                    .focused(
                        $focusedField,
                        equals:.email
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius:16
                        )
                        .stroke(
                            emailError != nil ? .red : .clear,
                            lineWidth: 1
                        )
                    )
                    .onChange(
                        of: email
                    ) { _, newValue in

                        if emailError != nil &&
                           isValidEmail(newValue) {

                            emailError = nil
                        }

                        if newValue.isEmpty {
                            emailError = nil
                        }
                    }
                    .onChange(
                        of: focusedField
                    ) { oldValue, newValue in

                        if oldValue == .email &&
                           newValue == .password {

                            validateEmail()
                        }
                    }


                    if let emailError {

                        Text(emailError)
                            .font(.system(size:16))
                            .foregroundStyle(.red)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)

                    }
                
                Spacer()
                    .frame(height: 8)

                VStack(alignment: .leading, spacing: 4) {

                    CustomTextField(
                        title:"Пароль",
                        text:$password,
                        isPassword:true,
                        showPassword:$showPassword
                    )
                    .focused(
                        $focusedField,
                        equals:.password
                    )
                    .overlay(
                        RoundedRectangle(
                            cornerRadius:16
                        )
                        .stroke(
                            passwordError != nil ? .red : .clear,
                            lineWidth:1.5
                        )
                    )
                    .onChange(
                        of: password
                    ) { _, newValue in

                        if newValue.isEmpty {
                            passwordError = nil
                        }
                    }


                    if let passwordError {

                        Text(passwordError)
                            .font(.system(size:16))
                            .foregroundStyle(.red)
                            .padding(.horizontal,16)
                            .padding(.bottom,20)
                    }
                }
                
                Spacer()
                    .frame(height: 8)


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
                            
                            if let apiError = error as? APIError {

                                if let passwordMessage = apiError.errors["password"] {
                                    passwordError = passwordMessage
                                }

                            }

                        }

                    }

                } label: {

                    Text("Продолжить")
                        .foregroundStyle(.white)
                        .font(.system(size:15,weight:.medium))
                        .frame(maxWidth:.infinity)
                        .frame(height:56)
                        .background(
                            isLoginValid ?
                            Color(
                                red:150/255,
                                green:94/255,
                                blue:235/255
                            )
                            :
                            Color.gray.opacity(0.4)
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius:16
                            )
                        )

                }
                .disabled(!isLoginValid)

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
