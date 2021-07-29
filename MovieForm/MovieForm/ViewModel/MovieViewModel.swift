//
//  MovieViewModel.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//

import Foundation
import UIKit

class MovieViewModel {
    
    var mediaJSON = """
    { "categories" :
        [
            {   "description" : "아주아주 귀여운 녀석들이 나타났다! Cute 카와이 동물들과 함께 당장 힐링하세요!",
                "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                "subtitle" : "By Blender Foundation",
                "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
                "title" : "Big Buck Bunny"
            },
            { "description" : "The first Blender Open Movie from 2006",
                "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
                "subtitle" : "By Blender Foundation",
                "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
                "title" : "Elephant Dream"
            },
            { "description" : "",
              "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
              "subtitle" : "By Google",
              "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
              "title" : "For Bigger Blazes"
            },
            { "description" : "",
              "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
                                  "subtitle" : "By Google",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg",
                                  "title" : "For Bigger Escape"
                                },
                                { "description" : "",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
                                  "subtitle" : "By Google",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg",
                                  "title" : "For Bigger Fun"
                                },
                                { "description" : "",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
                                  "subtitle" : "By Google",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg",
                                  "title" : "For Bigger Joyrides"
                                },
                                { "description" :"",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
                                  "subtitle" : "By Google",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerMeltdowns.jpg",
                                  "title" : "For Bigger Meltdowns"
                                },
                                { "description" : "",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
                                  "subtitle" : "By Blender Foundation",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/Sintel.jpg",
                                  "title" : "Sintel"
                                },
                                { "description" : "",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
                                  "subtitle" : "By Garage419",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/SubaruOutbackOnStreetAndDirt.jpg",
                                  "title" : "Subaru Outback On Street And Dirt"
                                },
                                { "description" : "",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
                                  "subtitle" : "By Blender Foundation",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/TearsOfSteel.jpg",
                                  "title" : "Tears of Steel"
                                },
                                { "description" : "",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
                                  "subtitle" : "By Garage419",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/VolkswagenGTIReview.jpg",
                                  "title" : "Volkswagen GTI Review"
                                },
                                { "description" : "",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
                                  "subtitle" : "By Garage419",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/WeAreGoingOnBullrun.jpg",
                                  "title" : "We Are Going On Bullrun"
                                },
                                { "description" : "",
                                  "sources" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
                                  "subtitle" : "By Garage419",
                                  "thumb" : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/WhatCarCanYouGetForAGrand.jpg",
                                  "title" : "What care can you get for a grand?"
                                }
                ]
                
        }
""".data(using: .utf8)!
    
    func getMovie(completed: @escaping (([detail])->Void)) {
        var movies = [detail]()
        do {
            let decoder = JSONDecoder()
            let mediaData = try! decoder.decode(media.self, from: mediaJSON)
            movies = mediaData.categories
        }
        completed(movies)
    }
}
