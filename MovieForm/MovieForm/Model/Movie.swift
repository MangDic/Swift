//
//  Movie.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//
import UIKit

class Movie {
    let title: String
    let key: String
    var thumbNail: UIImage
    
    init(title: String, key: String, thumbNail : UIImage) {
        self.title = title
        self.key = key
        self.thumbNail = thumbNail
    }
    
    func setThumbNail(thumbNail : UIImage) {
        self.thumbNail = thumbNail
    }
}
