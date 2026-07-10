//
//  CustomTextField.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 08.07.2026.
//

import SwiftUI


struct CustomTextField: View {


    var title:String

    @Binding var text:String

    var isPassword:Bool = false

    @Binding var showPassword:Bool



    init(
        title:String,
        text:Binding<String>,
        isPassword:Bool = false,
        showPassword:Binding<Bool> = .constant(false)
    ){

        self.title = title
        self._text = text
        self.isPassword = isPassword
        self._showPassword = showPassword

    }



    var body: some View {


        HStack {


            VStack(alignment:.leading,spacing:2) {


                if !text.isEmpty {


                    Text(title)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)


                }


                Group {

                    if isPassword && !showPassword {


                        SecureField(
                            text.isEmpty ? title : "",
                            text:$text
                        )
                        .font(.system(size: text.isEmpty ? 17 : 15))


                    } else {


                        TextField(
                            text.isEmpty ? title : "",
                            text:$text
                        )
                        .font(.system(size: text.isEmpty ? 17 : 15))


                    }

                }
                .font(.system(size:15))



            }



            Spacer()



            if !text.isEmpty {


                Button {

                    text = ""

                } label: {

                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.secondary)
                        .frame(width:12,height:12)

                }


            }



            if isPassword {
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .foregroundColor(.secondary)
                        .font(.system(size: 16))
                }
            }



        }
        .padding(.horizontal,16)
        .frame(height:56)
        .background(Color(.secondarySystemBackground))
        .clipShape(
            RoundedRectangle(
                cornerRadius:16
            )
        )
        .padding(.bottom,10)


    }

}
