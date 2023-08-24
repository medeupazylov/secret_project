//
//  AppliactionModel.swift
//  Muslink
//
//  Created by Аброрбек on 19.08.2023.
//

struct Mood: Codable {
    let id: Int
    let name: String
}

struct SubGenre: Codable {
    let id: Int
    let name: String
}

struct Purpose: Codable {
    let id: Int
    let name: String
}

enum Status: String, Codable {
    case sent = "SENT"
    case viewed = "VIEWED"
    case approved = "APPROVED"
    case declined = "DECLINED"
    case ignored = "IGNORED"
}

struct Application: Codable {
    let id: Int
    let track: Track
    let pitch: String
    let purposes: [Purpose]
    let status: Status
    let sendDate: String
    let comment: String
    let rejectReasons: [String]
    
//    enum CodingKeys: String, CodingKey {
//        case track
//        case pitch
//        case purposes
//        case status
//        case sendDate
//        case comment
//        case rejectReasons
//    }
}
