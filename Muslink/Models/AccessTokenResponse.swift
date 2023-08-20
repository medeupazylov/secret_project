//
//  YandexAccountDTO.swift
//  Muslink
//
//  Created by Аброрбек on 20.08.2023.
//

import Foundation

struct YandexAccountDTO: Codable {
    struct DefaultPhone: Codable {
        let id: Int
        let number: String
    }
    
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
}

struct AccessTokenResponse: Codable {
    let accessToken: String
    let yandexAccountDTO: YandexAccountDTO
}
