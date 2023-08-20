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
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}

extension City: SearchItem {
    var title: String {
        return name
    }
    
    var itemId : Int {
        return id
    }
}
