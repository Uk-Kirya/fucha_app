//
//  User.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 11.07.2026.
//

import Foundation


struct User: Codable {
    let id: Int
    let name: String
    let age: Int
    let city: String
    let email: String
}


struct UserResponse: Codable {
    let data: User
}
