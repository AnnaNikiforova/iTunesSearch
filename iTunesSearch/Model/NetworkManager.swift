//
//  NetworkManager.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 02.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import Foundation

let albumURL = "https://itunes.apple.com/search?entity=album&term="
let trackURL = "https://itunes.apple.com/lookup?entity=song&id="

class NetworkManager {
    
    func fetchAlbumData(searchString: String, complition: @escaping ([Album])->()) {
        var albums: [Album] = []
        let searchString = searchString.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: "\(albumURL)\(searchString)") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let downloadedAlbums = try JSONDecoder().decode(AlbumResult.self, from: data)
                albums = downloadedAlbums.results
                albums.sort { $0.name < $1.name }
                complition(albums)
            } catch {
                print(error)
            }
        } .resume()
        
    }
    
    func fetchTrackData(collectionIdString: Int, complition: @escaping ([Track])->()) {
        var tracks: [Track] = []
        guard let url = URL(string: "\(trackURL)\(collectionIdString)") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let downloadedTracks = try JSONDecoder().decode(TrackResult.self, from: data)
                for track in downloadedTracks.results {
                    if track.name != nil {
                        tracks = downloadedTracks.results
                        tracks.remove(at: 0)
                        complition(tracks)
                    }
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
}
