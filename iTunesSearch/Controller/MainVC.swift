//
//  MainVC.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 02.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    let cellIdentifier = "AlbumCell"
    let segueIdentifier = "ToDetailVC"
    var networkManager = NetworkManager()
    var albums = [Album]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
    }
    
    // MARK: Methods
    private func setupSearchBar() {
           searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
       }
    
    private  func setupCollectionView() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let destinationVC = segue.destination as! DetailVC
            destinationVC.album = sender as? Album
        }
    }
    
}

// MARK: - Collection View

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AlbumCell
        let album = albums[indexPath.row]
        cell.setAlbumCell(album: album)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: album)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let interItemSpacing: CGFloat = 20
        let labelStackHeight: CGFloat = 41
        let width = (collectionView.frame.width - (numberOfItemsPerRow - 1) * interItemSpacing) / numberOfItemsPerRow
        let height = width + labelStackHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

// MARK: - Search Bar

extension MainVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil || searchBar.text != "" {
            networkManager.fetchAlbumData(searchString: searchBar.text!) { albums in
                self.albums = albums
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }

}
