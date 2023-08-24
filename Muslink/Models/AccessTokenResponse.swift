//
//  YandexAccountDTO.swift
//  Muslink
//
//  Created by Аброрбек on 20.08.2023.
//

import Foundation

struct YandexAccountDTO: Codable {
    let firstName: String
    let lastName: String
    let displayName: String
    let emails: [String]
    let defaultEmail: String
    let defaultPhone: DefaultPhone
    let realName: String
    let isAvatarEmpty: Bool
    let birthday: String?
    let defaultAvatarId: String
    let login: String
    let oldSocialLogin: String?
    let sex: String?
    let id: String
    let clientId: String
    let psuid: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case displayName = "display_name"
        case emails
        case defaultEmail = "default_email"
        case defaultPhone = "default_phone"
        case realName = "real_name"
        case isAvatarEmpty = "is_avatar_empty"
        case birthday
        case defaultAvatarId = "default_avatar_id"
        case login
        case oldSocialLogin = "old_social_login"
        case sex
        case id
        case clientId = "client_id"
        case psuid
    }
}

struct AccessTokenResponse: Codable {
    let accessToken: String
    let yandexAccountDTO: YandexAccountDTO
}

struct DefaultPhone: Codable {
    let id: Int
    let number: String
}
