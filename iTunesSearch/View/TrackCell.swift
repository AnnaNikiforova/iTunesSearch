//
//  TrackCell.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 07.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    
    func setTrackCell(track: Track) {
        guard let trackNumber = track.number else { return }
        trackNumberLabel.text = String(trackNumber)
        trackNameLabel.text = track.name
    }
}
