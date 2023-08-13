//
//  City.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
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
