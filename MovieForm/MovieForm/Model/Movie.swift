//
//  Movie.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//
import UIKit

class Movie {
    let title: String
    let url: String
    let duration: String
    var thumbNail: UIImage
    
    init(title: String, url: String, thumbNail : UIImage, duration: String) {
        self.title = title
        self.url = url
        self.thumbNail = thumbNail
        self.duration = duration
    }
    
    func setThumbNail(thumbNail : UIImage) {
        self.thumbNail = thumbNail
    }
}
