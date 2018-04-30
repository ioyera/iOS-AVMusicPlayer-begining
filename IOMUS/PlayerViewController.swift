//
//  PlayerViewController.swift
//  IOMUS
//
//  Created by Yerassyl Duisenbi on 12.03.2018.
//  Copyright © 2018 Yerassyl Duisenbi. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var backgrounf: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var MusicImageView: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var volumer: UISlider!
    
    var trackID: Int = 0
    var library = MusicLibrary().library
    var audioPlayer: AVAudioPlayer!
    
    
//    var backgroundAudio = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: Bundle.main.path(forResource: "\(.trackID)", ofType: "mp3")!), error: nil)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    func setupNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
//        var timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
        
        

        
        if let coverImage = library[trackID]["coverImage"]{
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ("\(coverImage).jpg")), for: UIBarMetrics.default)
           MusicImageView.image = UIImage(named:"\(coverImage).jpg")
            backgrounf.image = MusicImageView.image
        }
        songName.text = library[trackID]["title"]
        artistName.text = library[trackID]["artist"]
        
        let path = Bundle.main.path(forResource: "\(trackID)", ofType: "mp3")
        
        
        if let path = path{
           let mp3URL = NSURL(fileURLWithPath: path)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL as URL)
                audioPlayer.play()
                
                var audioSession = AVAudioSession.sharedInstance()
                do{
                    try audioSession.setCategory(AVAudioSessionCategoryPlayback)
                }
                catch{
                    
                }
                
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }
//        slider.value = 0.0
//        slider.maximumValue = Float(audioPlayer.duration)
//        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: Selector(("updateSlider")), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func musicSlider(_ sender: UISlider) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(slider.value)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        
    }
//    func playbackSliderValueChanged(_ playbackSlider:UISlider){
//        let seconds: Int64 = Int64(playbackSlider.value)
//        let targetTime: CMTime = CMTimeMake(seconds, 1)
//
//
//
//
//    }

//    func updateSlider(){
//        slider.value = Float(audioPlayer.currentTime)
//    }
    
    @IBAction func play(_ sender: UIButton) {
        if audioPlayer.isPlaying{
           audioPlayer.pause()
        }else{
            audioPlayer.play()
            
        }
        
    }

    @IBAction func next(_ sender: UIButton) {
        if trackID == 0 || trackID < library.count {
            
            trackID += 1
        }
        
        
        
        if let coverImage = library[trackID]["coverImage"]{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ("\(coverImage).jpg")), for: UIBarMetrics.default)
            MusicImageView.image = UIImage(named:"\(coverImage).jpg")
            backgrounf.image = MusicImageView.image
        }
        songName.text = library[trackID]["title"]
        artistName.text = library[trackID]["artist"]
        
        let path = Bundle.main.path(forResource: "\(trackID)", ofType: "mp3")
        if let path = path{
            let mp3URL = NSURL(fileURLWithPath: path)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL as URL)
                audioPlayer.play()
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    
    
    
    }
    
    @IBAction func back(_ sender: UIButton) {
        if trackID != 0 || trackID>0{
            trackID -= 1
        }
        if let coverImage = library[trackID]["coverImage"]{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ("\(coverImage).jpg")), for: UIBarMetrics.default)
            MusicImageView.image = UIImage(named:"\(coverImage).jpg")
            backgrounf.image = MusicImageView.image
        }
        songName.text = library[trackID]["title"]
        artistName.text = library[trackID]["artist"]
        
        let path = Bundle.main.path(forResource: "\(trackID)", ofType: "mp3")
        if let path = path{
            let mp3URL = NSURL(fileURLWithPath: path)
            
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL as URL)
                audioPlayer.play()
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    @IBAction func soundSlider(_ sender: UISlider) {
        if audioPlayer != nil {
            audioPlayer?.volume = volumer.value
        }
    }
    
    

}
