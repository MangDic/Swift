//
//  MovieViewModel.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//

import Foundation
import UIKit

class MovieViewModel {
    func getMovie(completed: @escaping (([Movie])->Void)) {
        var movies = [Movie]()
        movies.append(Movie(title: "[TakeMeHome] 시연 영상", key: "UZK01HczJjA", thumbNail: UIImage()))
        movies.append(Movie(title: "[TMI] 시연 영상", key: "Z2akQLFzLl4", thumbNail: UIImage()))
        movies.append(Movie(title: "전구 시연 영상", key: "gSIZfMh9QGw", thumbNail: UIImage()))
        movies.append(Movie(title: "스위프트 데이터 전달 (Swift Send Data)", key: "heSWnMosg2o", thumbNail: UIImage()))
        movies.append(Movie(title: "스위프트 테이블뷰 (1) (Swift TableView)", key: "aZj49WHyBOs", thumbNail: UIImage()))
        movies.append(Movie(title: "스위프트 테이블뷰 (2) (Swift TableView)", key: "lx3aZ5vDRxs", thumbNail: UIImage()))
        for movie in movies {
            ImageLoader.loadImage(url: "https://img.youtube.com/vi/\(movie.key)/0.jpg") { image in
                movie.setThumbNail(thumbNail: image!)
            }
        }
        completed(movies)
    }
}
