//
//  NSObject+Extension.swift
//  Muslink
//
//  Created by Аброрбек on 18.08.2023.
//


import Foundation

extension NSObject {
    var className: String {
        return String(describing: self)
    }
}

