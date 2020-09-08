//
//  Extensions.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 07.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(url: String) {
        if let imageURL = URL(string: url) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
