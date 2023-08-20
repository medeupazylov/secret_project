//
//  AuthResponse.swift
//  Muslink
//
//  Created by Аброрбек on 20.08.2023.
//

import Foundation

struct AuthResponse: Codable {
    let oauthToken: String
    let role: String
}
