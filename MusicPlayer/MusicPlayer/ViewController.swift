//
//  ViewController.swift
//  VisionAPI
//
//  Created by 이명직 on 2021/06/18.
//

import UIKit
import Alamofire
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var lyrics: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var player : AVAudioPlayer!
    var timer : Timer!
    var isPlay = false
    
    let baseURL = "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMusic()
    }
    
    func getMusic() {
        
        let headers: HTTPHeaders = [
        ]
        
        let parameters: [String: Any] = [:]
        
        AF.request(baseURL, method: .get,
                   parameters: parameters, headers: headers)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    print(type(of: value))
                    self.setMusicItems(getData: value as! NSDictionary)
                    
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func setMusicItems(getData: NSDictionary) {
        
        self.durationLabel.text = "\(getData["duration"] as! Int)"
        let url = URL(string: getData["image"] as? String ?? "nil")
        do {
            let data = try Data(contentsOf: url!)
            self.thumbnailImage.image = UIImage(data: data)
        }
        catch {
            
        }
        
        let musicUrl = URL(string: getData["file"] as? String ?? "nil")
        do {
            let data = try Data(contentsOf: musicUrl!)
            try self.player = AVAudioPlayer(data: data)
        }
        catch {
            
        }
        self.slider.maximumValue = Float(self.player.duration)
        self.slider.minimumValue = 0
        self.slider.value = Float(self.player.currentTime)
        self.setDurationValue(time: self.player.duration)
        self.slider.thumbTintColor = UIColor.clear

        self.thumbnailImage.layer.cornerRadius = 10
        self.slider.minimumTrackTintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.currentLabel.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        self.lyrics.text = getData["lyrics"] as? String
        self.titleLabel.text = getData["title"] as? String
        self.singerLabel.text = getData["singer"] as? String
    }
    
    func setSliderValue(time: TimeInterval) {
        let min : Int = Int(time/60)
        let sec : Int = Int(time.truncatingRemainder(dividingBy: 60))
        
        let timeStr : String = String(format: "%02ld:%02ld", min,sec)
        
        self.currentLabel.text = timeStr
    }
    
    func setDurationValue(time: TimeInterval) {
        let min : Int = Int(time/60)
        let sec : Int = Int(time.truncatingRemainder(dividingBy: 60))
        
        let timeStr : String = String(format: "%02ld:%02ld", min,sec)
        
        self.durationLabel.text = timeStr
    }
    
    func setTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (Timer) in
            if self.slider.isTracking{ return}
            
            self.setSliderValue(time: self.player.currentTime)
            self.slider.value = Float(self.player.currentTime)
            
        })
        self.timer.fire()
    }
    
    func invalidatetimer() {
        self.timer?.invalidate()
        self.timer = nil
    
    }
    
    @IBAction func didTabPlayBtn(_ sender: Any) {
        if isPlay {
            playBtn.setImage(UIImage(named: "button_pause"), for: .normal)
            self.player?.pause()
            self.invalidatetimer()
            isPlay = false
        }
        else {
            playBtn.setImage(UIImage(named: "button_play"), for: .normal)
            self.player?.play()
            self.setTimer()
            isPlay = true
        }
    }
    @IBAction func didSwipeSlider(_ sender: UISlider) {
        self.setSliderValue(time: TimeInterval(sender.value))
        if sender.isTracking{return}
        self.player.currentTime = TimeInterval(sender.value)
    }
    
}
