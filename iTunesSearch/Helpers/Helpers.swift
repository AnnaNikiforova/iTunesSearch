//
//  Helpers.swift
//  iTunesSearch
//
//  Created by Анна Никифорова on 05.09.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class Helpers {
    static func addRoundedCorners(to imageView: UIImageView) {
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    static func formatDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:SS'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return ""
    }
}


