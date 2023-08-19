//
//  Goal.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 17.08.2023.
//

import Foundation

struct Goal: Codable {
    var title: String
    var checked: Bool
    
    init(title: String, checked: Bool) {
        self.title = title
        self.checked = checked
    }
}
