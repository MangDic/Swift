//
//  MoviePlayerViewController.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/20.
//

import UIKit
import AVFoundation

class MoviePlayerViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    
    var getUrl = ""
    var player = AVPlayer()
    var playerLayer: AVPlayerLayer!
    var isVideoPlaying = false {
        willSet {
            if newValue {
                UIView.animate(withDuration: 0.5, animations: {
                    self.controlView.alpha = 0.0
                    self.cancelButton.alpha = 0.0
                       }) { (result) in
            
                    self.controlView.isHidden = true
                    self.cancelButton.isHidden = true
                }
                
            }
            else {
                UIView.animate(withDuration: 0.5, animations: {
                                self.controlView.isHidden = false
                                self.controlView.alpha = 1
                    
                    self.cancelButton.isHidden = false
                    self.cancelButton.alpha = 1
                            })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.landscapeRight, andRotateTo: UIInterfaceOrientation.landscapeRight)
        self.navigationController?.navigationBar.isHidden = true
        player.play()
        isVideoPlaying = true
        playerLayer.frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: getUrl)!
        player = AVPlayer(url: url)
        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        
        addTimeObserver()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        mainView.layer.addSublayer(playerLayer)

        let videoTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapVideoView(gestureRecognizer:)))
        
        let controllerTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapVideoController(gestureRecognizer:)))
        
        setThumbs()
        mainView.addGestureRecognizer(videoTapRecognizer)
        controlView.addGestureRecognizer(controllerTapRecognizer)
        cancelButton.layer.cornerRadius = 10
        setPlayOrPause()
    }
    
    
    @objc func tapVideoController(gestureRecognizer: UIGestureRecognizer) {
        print("Video Controller Tap")
    }
    
    @objc func tapVideoView(gestureRecognizer: UIGestureRecognizer) {
        setPlayOrPause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = mainView.bounds
        
        controlView.layer.zPosition = 999
        cancelButton.layer.zPosition = 999
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        setPlayOrPause()
    }
    @IBAction func forewardButtonPressed(_ sender: Any) {
        guard let duration = player.currentItem?.duration else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 5.0
        
        if newTime < (CMTimeGetSeconds(duration) - 5.0) {
            let time: CMTime = CMTimeMake(value: Int64(newTime)*1000, timescale: 1000)
            player.seek(to: time)
        }
    }
    @IBAction func backwardButtonPressed(_ sender: Any) {
        guard let duration = player.currentItem?.duration else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 5.0
        
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        player.seek(to: time)
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        player.seek(to: CMTimeMake(value: Int64(sender.value*1000), timescale: 1000))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "duration", let duration = player.currentItem?.duration.seconds, duration > 0.0 {
            self.durationLabel.text = getTimeString(from: player.currentItem!.duration)
        }
    }
    
    func setPlayOrPause() {
        if isVideoPlaying {
            player.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
        }
        else {
            player.play()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isVideoPlaying = !isVideoPlaying
    }
    
    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { (time) in
            guard let currentItem = self.player.currentItem else { return }
            self.timeSlider.maximumValue = Float(currentItem.duration.seconds)
            self.timeSlider.minimumValue = 0
            self.timeSlider.value = Float(currentItem.currentTime().seconds)
            self.currentLabel.text = self.getTimeString(from: currentItem.currentTime())
        })
    }
    
    func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours, minutes, seconds])
        }
        return String(format: "%02i:%02i", arguments: [minutes, seconds])
    }
    
    fileprivate func setThumbs() {
        timeSlider.setThumbImage(thumbImage(), for: .normal)
        volumeSlider.setThumbImage(thumbImage(), for: .normal)
    }
    
    fileprivate func thumbImage() -> UIImage {
        let thumbView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        thumbView.backgroundColor = .white
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        return renderer.image { context in
            thumbView.layer.render(in: context.cgContext)
        }
    }
    
}
