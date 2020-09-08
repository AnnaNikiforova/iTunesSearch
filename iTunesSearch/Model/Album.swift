//
//  Album.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 02.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import Foundation

struct AlbumResult: Codable {
    var results: [Album]
}

struct Album: Codable {
    var name: String
    var collectionId: Int
    var artist: String
    var genre: String
    var year: String
    var artwork: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "collectionName"
        case collectionId
        case artist = "artistName"
        case genre = "primaryGenreName"
        case year = "releaseDate"
        case artwork = "artworkUrl100"
    }
}
