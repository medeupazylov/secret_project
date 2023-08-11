//
//  Artist.swift
//  Muslink
//
//  Created by Аброрбек on 11.08.2023.
//

import Foundation

struct Artist: Codable {
    let name: String
    let nickname: String
    let city: String
    let socialNetworks: [String]
    let contacts: [String]
    let genres: [String]?
    let moods: [String]?
    let biography: [String]?
    let photo: [String]?
}

