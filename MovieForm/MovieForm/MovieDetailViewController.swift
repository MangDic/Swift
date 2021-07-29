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
    @IBOutlet weak var subTitle: UITextView!
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var flowLayout = UICollectionViewFlowLayout()
    let viewModel = MovieViewModel()
    var recomendData = [detail]()
    var getMovie = detail(description: "", sources: "", subtitle: "", thumb: "", title: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
        
        flowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        
        flowLayout.itemSize = CGSize(width: collectionView.frame.width*0.4, height: collectionView.frame.height*0.8)
        flowLayout.scrollDirection = .horizontal
        
        getRecomendData()
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    func getRecomendData() {
        self.titleStr.text = getMovie.title
        self.subTitle.text = getMovie.description
        self.recomendData = [detail]()
        ImageLoader.loadImage(url: getMovie.thumb) { image in
            self.thumbView.image = image
        }
        viewModel.getMovie() { result in
            for item in result {
                if item.title != self.getMovie.title {
                    self.recomendData.append(item)
                }
            }
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(CGPoint.zero, animated: true)
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
        return recomendData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! recommendCell
        
        ImageLoader.loadImage(url: recomendData[indexPath.row].thumb) { image in
            cell.thumbNail.image = image
        }
        cell.thumbNail.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.getMovie = recomendData[indexPath.row]
        getRecomendData()
    }
}
