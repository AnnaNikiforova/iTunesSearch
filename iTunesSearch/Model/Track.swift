//
//  Track.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 03.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import Foundation

struct TrackResult: Codable {
    var results: [Track]
}

struct Track: Codable {
    var name: String?
    var number: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case number = "trackNumber"
    }
}
