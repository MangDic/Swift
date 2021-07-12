//
//  ImageLoader.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//

import UIKit

class ImageLoader {
    static func loadImage(url: String, completed: @escaping (UIImage?) -> Void) {
        do {
            print("url : \(url)")
            guard let setURL = URL(string: url) else {
                completed(UIImage())
                return
            }
            let data = try Data(contentsOf: setURL)
            completed(UIImage(data: data))
        }
        catch {
            
        }

    }
}
