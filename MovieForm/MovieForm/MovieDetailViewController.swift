//
//  MovieDetailViewController.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//

import UIKit
import WebKit

class recommendCell: UICollectionViewCell {
    @IBOutlet weak var thumbNail: UIImageView!
    
}

class MovieDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var titleStr: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var flowLayout = UICollectionViewFlowLayout()
    let viewModel = MovieViewModel()
    var recomendData = [detail]()
    var getMovie = detail(description: "", sources: "", subtitle: "", thumb: "", title: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        guard getMovie.title != "" else {
            return
        }
        self.titleStr.text = getMovie.title
        self.subTitle.text = getMovie.description
        ImageLoader.loadImage(url: getMovie.thumb) { image in
            self.thumbView.image = image
        }
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        
        flowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        
        flowLayout.itemSize = CGSize(width: collectionView.frame.width*0.6, height: collectionView.frame.height*0.8)
        flowLayout.scrollDirection = .horizontal
        
        getRecomendData()
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    func getRecomendData() {
        viewModel.getMovie() { result in
            self.recomendData = result
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "sendMovie" == id {
            if let controller = segue.destination as? MoviePlayerViewController {
                
                controller.getUrl = getMovie.sources
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! recommendCell
        
        ImageLoader.loadImage(url: recomendData[indexPath.row].thumb) { image in
            cell.thumbNail.image = image
            
        }
        return cell
    }
}
