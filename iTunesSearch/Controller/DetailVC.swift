//
//  DetailVC.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 05.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var album: Album?
    let cellIdentifier = "trackCell"
    var tracks = [Track]()
    
    @IBOutlet weak var artworkImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTrackData()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }
    
    // MARK: Methods
    func fetchTrackData() {
        guard let album = album else { return }
        NetworkManager.fetchTrackData(collectionIdString: album.collectionId) { tracks in
            self.tracks = tracks
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func setUI() {
        Helpers.addRoundedCorners(to: artworkImage)
        
        guard let album = album else { return }
        loadImage(url: album.artwork)
        albumNameLabel.text = album.name
        artistLabel.text = album.artist
        genreLabel.text = album.genre
        yearLabel.text = Helpers.formatDate(date: album.year)
        
        tableView.tableFooterView = UIView()
        activityIndicator.hidesWhenStopped = true
    }
    
    func loadImage(url: String) {
        if let imageURL = URL(string: url) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.artworkImage.image = image
                    }
                }
            }
        }
    }
    
}

// MARK: - Table View

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TrackCell
        let track = tracks[indexPath.row]
        cell.setTrackCell(track: track)
        return cell
    }
}
