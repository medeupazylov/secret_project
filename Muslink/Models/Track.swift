//
//  Tracks.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
//

import Foundation

struct Track: Codable {
    let id: Int
    let link: String
    
    init(id: Int = 0, link: String){
        self.id = id
        self.link = link
    }
}
