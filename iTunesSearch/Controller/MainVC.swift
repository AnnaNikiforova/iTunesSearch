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
    var albums = [Album]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        setupActivityIndicator()
        hideKeyboardWhenTappedElsewhere()
    }
    
    // MARK: Methods
    private func setupSearchBar() {
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    private  func setupCollectionView() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }
    
    private func showActivityController() {
        let ac = UIAlertController(title: "Oops! We can't find any items matching your search.", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try again", style: .cancel))
        present(ac, animated: true)
    }
    
    private func hideKeyboardWhenTappedElsewhere() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        let edgeInsetsSum: CGFloat = 40
        let width = (collectionView.frame.width - edgeInsetsSum - (numberOfItemsPerRow - 1) * interItemSpacing) / numberOfItemsPerRow
        let height = width + labelStackHeight
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
    }
    
}

// MARK: - Search Bar

extension MainVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.startAnimating()
        
        // fetches data if search text isn't empty
        if searchBar.text?.isEmpty != true {
            NetworkManager.fetchAlbumData(searchString: searchBar.text!) { albums in
                self.albums = albums
                
                // albums load if search is valid
                if albums.isEmpty != true {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                    // alert pops up if search is not valid
                } else {
                    DispatchQueue.main.async {
                        self.showActivityController()
                    }
                }
            }
            
            // alert pops up if search text is empty
        } else {
            self.showActivityController()
        }
        
        activityIndicator.stopAnimating()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            albums.removeAll()
            collectionView.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
}
