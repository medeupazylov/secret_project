//
//  Color.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 05.08.2023.
//

import UIKit

enum Color {
    case neutral100
    case neutral80
    case neutral72
    case neutral32
    case neutral16

    case primaryBgColor
    case elevatedBgColor
    case bgColor20
    case primaryMain
    case primaryPressed
    case primaryHover
    case primaryFocus
    case primaryBorder
    
    case accentMain
    case accentPressed
    case accentHover
    case accentFocus
    case accentBorder
    
    case successMain
    case successBgColor
    case successPressed
    case successHover
    case successFocus
    case successBorder
    
    case warningMain
    case warningBgColor
    case warningPressed
    case warningHover
    case warningFocus
    case warningBorder
    
    case dangerMain
    case dangerBgColor
    case dangerPressed
    case dangerHover
    case dangerFocus
    case dangerBorder
    
    case infoMain
    case infoBgColor
    case infoPressed
    case infoHover
    case infoFocus
    case infoBorder
    
}

extension Color {
    var color: UIColor {
        var color: UIColor?

        switch self {
        case .neutral100:
            color = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        case .neutral80:
            color = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
        case .neutral72:
            color = UIColor(red: 255, green: 255, blue: 255, alpha: 0.72)
        case .neutral32:
            color = UIColor(red: 255, green: 255, blue: 255, alpha: 0.32)
        case .neutral16:
            color = UIColor(red: 255, green: 255, blue: 255, alpha: 0.16)
            
            
        case .primaryBgColor:
            color = UIColor(red: 21, green: 24, blue: 36, alpha: 1)
        case .elevatedBgColor:
            color = UIColor(red: 34, green: 39, blue: 56, alpha: 1)
        case .bgColor20:
            color = UIColor(red: 100, green: 136, blue: 180, alpha: 0.2)
        case .primaryMain:
            color = UIColor(red: 184, green: 126, blue: 238, alpha: 1)
        case .primaryPressed:
            color = UIColor(red: 34, green: 15, blue: 128, alpha: 1)
        case .primaryHover:
            color = UIColor(red: 105, green: 77, blue: 249, alpha: 1)
        case .primaryFocus:
            color = UIColor(red: 226, green: 220, blue: 255, alpha: 1)
        case .primaryBorder:
            color = UIColor(red: 188, green: 176, blue: 245, alpha: 1)
            
            
        case .accentMain:
            color = UIColor(red: 254, green: 211, blue: 44, alpha: 1)
        case .accentPressed:
            color = UIColor(red: 222, green: 177, blue: 1, alpha: 1)
        case .accentHover:
            color = UIColor(red: 255, green: 219, blue: 80, alpha: 1)
        case .accentFocus:
            color = UIColor(red: 255, green: 240, blue: 180, alpha: 1)
        case .accentBorder:
            color = UIColor(red: 255, green: 229, blue: 129, alpha: 1)
            
        
        case .successMain:
            color = UIColor(red: 33, green: 114, blue: 94, alpha: 1)
        case .successBgColor:
            color = UIColor(red: 231, green: 250, blue: 245, alpha: 1)
        case .successPressed:
            color = UIColor(red: 22, green: 76, blue: 63, alpha: 1)
        case .successHover:
            color = UIColor(red: 27, green: 95, blue: 78, alpha: 1)
        case .successFocus:
            color = UIColor(red: 200, green: 235, blue: 226, alpha: 1)
        case .successBorder:
            color = UIColor(red: 181, green: 208, blue: 201, alpha: 1)
        
            
        case .warningMain:
            color = UIColor(red: 224, green: 206, blue: 44, alpha: 1)
        case .warningBgColor:
            color = UIColor(red: 254, green: 250, blue: 220, alpha: 1)
        case .warningPressed:
            color = UIColor(red: 149, green: 137, blue: 29, alpha: 1)
        case .warningHover:
            color = UIColor(red: 187, green: 172, blue: 37, alpha: 1)
        case .warningFocus:
            color = UIColor(red: 253, green: 248, blue: 207, alpha: 1)
        case .warningBorder:
            color = UIColor(red: 245, green: 239, blue: 185, alpha: 1)
            
        case .dangerMain:
            color = UIColor(red: 224, green: 81, blue: 81, alpha: 1)
        case .dangerBgColor:
            color = UIColor(red: 255, green: 232, blue: 232, alpha: 1)
        case .dangerPressed:
            color = UIColor(red: 84, green: 18, blue: 18, alpha: 1)
        case .dangerHover:
            color = UIColor(red: 140, green: 31, blue: 31, alpha: 1)
        case .dangerFocus:
            color = UIColor(red: 255, green: 223, blue: 223, alpha: 1)
        case .dangerBorder:
            color = UIColor(red: 226, green: 182, blue: 182, alpha: 1)
            
            
        case .infoMain:
            color = UIColor(red: 0, green: 35, blue: 221, alpha: 1)
        case .infoBgColor:
            color = UIColor(red: 235, green: 238, blue: 255, alpha: 1)
        case .infoPressed:
            color = UIColor(red: 0, green: 23, blue: 147, alpha: 1)
        case .infoHover:
            color = UIColor(red: 0, green: 29, blue: 184, alpha: 1)
        case .infoFocus:
            color = UIColor(red: 226, green: 231, blue: 255, alpha: 1)
        case .infoBorder:
            color = UIColor(red: 170, green: 182, blue: 244, alpha: 1)
        }

        return color ?? UIColor()
    }
}
