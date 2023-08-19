//
//  Reason.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 19.08.2023.
//

import Foundation

struct Reason: Codable {
    var title: String
    var checked: Bool
    
    init(title: String, checked: Bool) {
        self.title = title
        self.checked = checked
    }
}
