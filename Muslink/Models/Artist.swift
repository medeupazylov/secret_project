//
//  Artist.swift
//  Muslink
//
//  Created by Аброрбек on 11.08.2023.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    
    init(id: Int = 0, name: String){
        self.id = id
        self.name = name
    }
}

struct SocialNetwork: Codable {
    let mediaType: String
    let link: String
}

struct Genre: Codable {
    let id: Int
    let name: String
    
    init(id: Int = 0, name: String){
        self.id = id
        self.name = name
    }
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


