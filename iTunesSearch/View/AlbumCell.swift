//
//  AlbumCell.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 02.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {

    let imageCache = NSCache<AnyObject, AnyObject>()
    
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Helpers.addRoundedCorners(to: artworkImage)
    }
    
    func setAlbumCell(album: Album) {
        loadImage(url: album.artwork)
        albumNameLabel.text = album.name
        artistLabel.text = album.artist
    }
    
    // loads and caches image
    func loadImage(url: String) {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.artworkImage.image = imageFromCache
        } else {
            if let imageURL = URL(string: url) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        if let imageToCache = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                                self.artworkImage.image = imageToCache
                            }
                        }
                    }
                }
            }
        }
    }
    
}
