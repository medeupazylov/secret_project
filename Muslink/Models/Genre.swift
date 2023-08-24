//
//  Genre.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
//

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
    
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
}

extension Genre: SearchItem {
    var title: String {
        return self.name
    }
    var itemId: Int {
        return self.id
    }
}
