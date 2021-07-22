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
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var viewAndDurationStack: UIStackView!
    
}

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewFlag = false
    var movies = [Movie]()
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
        //flowLayout.itemSize = CGSize(width: w, height: h*0.35)
        
        collectionView.collectionViewLayout = flowLayout
        
        assert(self.navigationController != nil, "self.navigationController must not be nil")
        self.title = "MovieList"
    
        setNavigationBarButtons()
        //getMovies()
        
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
    }
    
    @objc func refreshButtonDidTap() {
        movieViewModel.getMovie() { result in
            self.movies = result
            self.collectionView.reloadData()
            self.collectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }


    @objc func changeButtonDidTap() {
        viewFlag = !viewFlag
        if viewFlag {
            navigationItem.rightBarButtonItem?.title = "Cell"
        }
        else {
            navigationItem.rightBarButtonItem?.title = "List"
        }
        changeCellsByDirection()
        collectionView.reloadData()
    }
    
    fileprivate func changeCellsByDirection() {
        if viewFlag {
            print("셀모드")
            flowLayout.itemSize = CGSize(width: w*0.45, height: h*0.25)
        }
        else {
            print("리스트모드")
            flowLayout.itemSize = CGSize(width: w, height: h*0.35)
        }    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
               // url 가져오고 언래핑해준다.
               let url = URL(string: "https://va.media.tumblr.com/tumblr_o600t8hzf51qcbnq0_480.mp4")!
               // AVPlayerItem으로 url을 가져와 아이템으로 만들어주고
        let item = AVPlayerItem(url: url)
               // 이용할 스토리보드를 고르고
               let sb = UIStoryboard(name: "Main", bundle: nil)
               let vc = sb.instantiateViewController(identifier: "MoviePlayerViewController") as! MoviePlayerViewController
        vc.modalPresentationStyle = .fullScreen
               
               // 아이템을 삽입해주고
               vc.player.replaceCurrentItem(with: item)
               // 실행!
               present(vc, animated: false, completion: nil)
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
