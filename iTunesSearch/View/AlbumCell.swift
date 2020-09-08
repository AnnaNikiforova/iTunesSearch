//
//  AlbumCell.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 02.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {

    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Helpers.addRoundedCorners(to: artworkImage)
    }
    
    func setAlbumCell(album: Album) {
        artworkImage.imageFromUrl(url: album.artwork)
        albumNameLabel.text = album.name
        artistLabel.text = album.artist
    }
}
