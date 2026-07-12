//
//  LoginResponse.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 12.07.2026.
//

struct LoginResponse: Decodable {

    let success: Bool
    let access_token: String
    let refresh_token: String

}

struct APIError: Decodable {

    let success: Bool
    let errors: [String:String]

}
