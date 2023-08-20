//
//  Tracks.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
//

import Foundation

struct Track: Codable {
    struct TrackInfo: Codable {
        let id: Int
        let link: String
    }
    
    let track: TrackInfo
    let name: String
    let language: String
    let genres: [Genre]
    let subGenres: [SubGenre]
    let moods: [Mood]
}
