//
//  LoginResponse.swift
//  JetDemo
//
//  Created by Virani Bhavesh Madhavajibhai on 09/12/22.
//

import Foundation



import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let result: Int
    let errorMessage: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: User?
}

// MARK: - User
struct User: Codable {
    let userID: Int?
    let userName: String?
    let userProfileURL: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case userProfileURL = "user_profile_url"
        case createdAt = "created_at"
    }
}
