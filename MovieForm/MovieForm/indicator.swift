//
//  indicator.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//

import Foundation
import UIKit

func createIndicator() -> UIActivityIndicatorView { // Create an indicator.
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50) // Also show the indicator even when the animation is stopped.
    activityIndicator.hidesWhenStopped = false
    activityIndicator.style = UIActivityIndicatorView.Style.large
    activityIndicator.color = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
    return activityIndicator
    
}

