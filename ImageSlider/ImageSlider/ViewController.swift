//
//  ViewController.swift
//  ImageSlider
//
//  Created by 이명직 on 2021/08/06.
//

import UIKit
import ImageSlideshow

class ViewController: UIViewController {

    @IBOutlet weak var imageSlide: ImageSlideshow!
    
    let imageResources = [
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1511044568932-338cba0ad803?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2F0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2F0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1533743983669-94fa5c4338ec?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGNhdHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSlide.setImageInputs(imageResources)
        imageSlide.contentScaleMode = .scaleAspectFill
        // 1초마다 슬라이드
        imageSlide.slideshowInterval = 1
        // 사용자 터치 허용
        imageSlide.isUserInteractionEnabled = false
    }
    
    let labelIndicator: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "TEST LABEL"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func didTap(_ sender: UITapGestureRecognizer? = nil) {
        print("Viewcontroller - didTap() called")
        
        // 클릭 시 해당 이미지 확대
        let fullScreenController = secondImageSlideShow.presentFullScreenController(from: self, completion: nil)
        fullScreenController.view.addSubview(labelIndicator)
        labelIndicator.topAnchor.constraint(equalTo: fullScreenController.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        labelIndicator.centerXAnchor.constraint(equalTo: fullScreenController.view.centerXAnchor).isActive = true
        let currentPageString = String(fullScreenController.slideshow.currentPage + 1)
        labelIndicator.text = currentPageString + " / \(fullScreenController.slideshow.images.count)"
        
        fullScreenController.slideshow.delegate = self
    }
    
    // 코드로 작성
    let secondImageSlideShow: ImageSlideshow = {
       let slideShow = ImageSlideshow()
        slideShow.isUserInteractionEnabled = true
        slideShow.slideshowInterval = 1.5
        slideShow.contentScaleMode = .scaleAspectFill
        return slideShow
    }()
    
    let labelBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.4191371084)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        let labelPageIndicator = LabelPageIndicator()
        labelPageIndicator.textColor = .white
        secondImageSlideShow.pageIndicator = labelPageIndicator
        secondImageSlideShow.setImageInputs(imageResources)
        
        self.view.addSubview(secondImageSlideShow)
        
        secondImageSlideShow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondImageSlideShow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            secondImageSlideShow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            secondImageSlideShow.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            secondImageSlideShow.heightAnchor.constraint(equalToConstant: 300)
        
        ])
        
        secondImageSlideShow.addSubview(labelBackgroundView)
        
        NSLayoutConstraint.activate([
            labelBackgroundView.centerXAnchor.constraint(equalTo: labelPageIndicator.centerXAnchor),
            labelBackgroundView.centerYAnchor.constraint(equalTo: labelPageIndicator.centerYAnchor),
            labelBackgroundView.widthAnchor.constraint(equalTo: labelPageIndicator.widthAnchor, multiplier: 1.2),
            labelBackgroundView.heightAnchor.constraint(equalTo: labelPageIndicator.heightAnchor, multiplier: 1.2)
            
        
        ])
        
        // secondImageSlideShow의 하위 뷰 중에서 labelPageIndicator 를 맨 앞으로 가져오겠다!
        secondImageSlideShow.bringSubviewToFront(labelPageIndicator)
        
        print("UIDevide.current.hasNotch : \(UIDevice.current.hasNotch)")
        
        secondImageSlideShow.pageIndicatorPosition = .init(horizontal: .right(padding: 20), vertical: .customBottom(padding: UIDevice.current.hasNotch == true ? -10 : 20))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        secondImageSlideShow.addGestureRecognizer(tapGesture)
    }


}

extension ViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("ViewController - didChangeCurrentPageTo() called : \(page)")
        labelIndicator.text = String(page + 1) + " / \(String(imageSlideshow.images.count))"
    }
}

// 현재 디바이스를 익스텐션하여 노치 대응
extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            // 노치가 아님
            if UIApplication.shared.windows.count == 0 { return false }
            let top = UIApplication.shared.windows[0].safeAreaInsets.top
            // 20보다 크면 노치가 있다는 소리
            return top > 20
        }
        else {
            return false
        }
    }
}
