//
//  Artist.swift
//  Muslink
//
//  Created by Аброрбек on 11.08.2023.
//

import Foundation

struct SocialNetwork: Codable {
    let mediaType: String
    let link: String
}

struct Photo: Codable {
    let id: Int
    let link: String
    
    init(id: Int = 0, link: String){
        self.id = id
        self.link = link
    }
}

struct Artist: Codable {
    let name: String
    let nickname: String
    let city: City
    let socialNetworks: [SocialNetwork]
    let genres: [Genre]
    let photos: [Photo]
}


