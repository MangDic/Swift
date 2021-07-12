//
//  MovieDetailViewController.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleStr: UILabel!
    
    var getKey = "lx3aZ5vDRxs"
    var getMovie = Movie(title: "", key: "", thumbNail: UIImage())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://www.youtube.com/embed/\(getMovie.key)") else { return  }
        webView.load(URLRequest(url: url))
        guard getMovie.title != "" else {
            return
        }
        self.titleStr.text = getMovie.title

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
