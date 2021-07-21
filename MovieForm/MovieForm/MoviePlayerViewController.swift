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
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    var player = AVPlayer()
    var playerLayer: AVPlayerLayer!
    var isVideoPlaying = true
    var isShowController = true {
        willSet {
            if newValue {
                UIView.animate(withDuration: 0.5, animations: {
                    self.controlView.alpha = 0.0
                       }) { (result) in
                    self.controlView.isHidden = true
                }
                
            }
            else {
                UIView.animate(withDuration: 0.5, animations: {
                                self.controlView.isHidden = false
                                self.controlView.alpha = 1
                            })
            }
        }
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//            return .landscapeRight
//        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
//        let url = URL(string: "https://va.media.tumblr.com/tumblr_o600t8hzf51qcbnq0_480.mp4")!
//        player = AVPlayer(url: url)
//        player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        
        addTimeObserver()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        videoView.layer.addSublayer(playerLayer)
        controlView.layer.zPosition = 999

        let videoTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapVideoView(gestureRecognizer:)))
        
        let controllerTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapVideoController(gestureRecognizer:)))
        
        videoView.addGestureRecognizer(videoTapRecognizer)
        controlView.addGestureRecognizer(controllerTapRecognizer)
    }
    
    
    @objc func tapVideoController(gestureRecognizer: UIGestureRecognizer) {
        print("Video Controller Tap")
    }
    
    @objc func tapVideoView(gestureRecognizer: UIGestureRecognizer) {
        isShowController = !isShowController
        setPlayOrPause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
        
        let height = UIScreen.main.bounds.height*0.15
        self.controlView.frame.size.height = height
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
            playButton.setTitle("Play", for: .normal)
        }
        else {
            player.play()
            playButton.setTitle("Pause", for: .normal)
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
    
}
