//
//  ViewController.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//

import UIKit
import AVFoundation

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var thumnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewFlag = false
    var movies = [detail]()
    var flowLayout = UICollectionViewFlowLayout()
    let movieViewModel = MovieViewModel()
    let w : CGFloat = UIScreen.main.bounds.width
    let h : CGFloat = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.detectOrientation), name: NSNotification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)

        
        
        movieViewModel.getMovie() { result in
            self.movies = result
        }
        
        flowLayout = UICollectionViewFlowLayout()
        changeCellsByDirection()
        
        collectionView.collectionViewLayout = flowLayout
        
        assert(self.navigationController != nil, "self.navigationController must not be nil")
    
        setNavigationBarButtons()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @objc func detectOrientation() {
        changeCellsByDirection()
    }
    
    private func setNavigationBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cell", style: .plain, target: self, action: #selector(changeButtonDidTap))
        
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func refreshButtonDidTap() {
        movieViewModel.getMovie() { result in
            //self.movies = result
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }


    @objc func changeButtonDidTap() {
        viewFlag = !viewFlag
        if viewFlag {
            navigationItem.rightBarButtonItem?.title = "List"
            navigationItem.rightBarButtonItem?.image = UIImage(named: "")
        }
        else {
            navigationItem.rightBarButtonItem?.title = "Cell"
        }
        changeCellsByDirection()
        collectionView.reloadData()
    }
    
    fileprivate func changeCellsByDirection() {
        if viewFlag {
            flowLayout.itemSize = CGSize(width: w / 2.0 - 10, height: h*0.23)
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        else {
            flowLayout.itemSize = CGSize(width: w, height: h*0.35)
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.title.text = movies[indexPath.row].title
        ImageLoader.loadImage(url: movies[indexPath.row].thumb) { image in
            cell.thumnail.image = image
        }
        cell.thumnail.layer.cornerRadius = 10
        cell.subTitle.text = movies[indexPath.row].subtitle
        cell.subTitle.isHidden = false
        cell.title.isHidden = false
        if viewFlag {
            cell.subTitle.isHidden = true
            cell.title.isHidden = true
        }
    
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "detail" == id {
            if let controller = segue.destination as? MovieDetailViewController {
                if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                    controller.getMovie = movies[indexPath.row]
                }
            }
        }
    }
}
