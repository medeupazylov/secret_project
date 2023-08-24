//
//  Tracks.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
//

import Foundation

struct TrackFile: Codable {
    let id: Int
    let link: String
}

struct Track: Codable {
    
    let track: TrackFile
    let name: String
    let language: String
    let genres: [Genre]
    let subGenres: [SubGenre]
    let moods: [Mood]
    let startCrop: Int
    let endCrop: Int
}
