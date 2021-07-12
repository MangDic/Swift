//
//  ViewController.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/12.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var thumnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var viewAndDurationStack: UIStackView!
    
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewFlag = false
    var movies = [Movie]()
    var flowLayout = UICollectionViewFlowLayout()
    let movieViewModel = MovieViewModel()
    let w : CGFloat = UIScreen.main.bounds.width
    let h : CGFloat = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieViewModel.getMovie() { result in
            self.movies = result
        }
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: w, height: h*0.35)
        
        collectionView.collectionViewLayout = flowLayout
        
        assert(self.navigationController != nil, "self.navigationController must not be nil")
        self.title = "MovieList"
    
        setNavigationBarButtons()
        //getMovies()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    private func setNavigationBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cell", style: .plain, target: self, action: #selector(changeButtonDidTap))
    }
    
    @objc func refreshButtonDidTap() {
        movieViewModel.getMovie() { result in
            self.movies = result
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }


    @objc func changeButtonDidTap() {
        if viewFlag {
            viewFlag = !viewFlag
            navigationItem.rightBarButtonItem?.title = "Cell"
            flowLayout.itemSize = CGSize(width: w, height: h*0.35)
            collectionView.reloadData()
        }
        else {
            viewFlag = !viewFlag
            navigationItem.rightBarButtonItem?.title = "List"
        
            flowLayout.itemSize = CGSize(width: w*0.45, height: h*0.25)
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.title.text = movies[indexPath.row].title
        cell.thumnail.layer.cornerRadius = 8
        cell.thumnail.image = movies[indexPath.row].thumbNail
        
        if viewFlag {
            cell.viewAndDurationStack.isHidden = true
            cell.userImage.isHidden = true
        }
        else {
            cell.viewAndDurationStack.isHidden = false
            cell.userImage.isHidden = false
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "sendMovie" == id {
            if let controller = segue.destination as? MovieDetailViewController {
                if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                    controller.getMovie = Movie(title:  movies[indexPath.row].title, key:  movies[indexPath.row].key, thumbNail: movies[indexPath.row].thumbNail)
                }
            }
        }
    }
}
