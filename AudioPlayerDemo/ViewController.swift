//
//  ViewController.swift
//  AudioPlayerDemo
//
//  Created by Avani Patel on 6/8/20.
//  Copyright © 2020 Avani Patel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var scrubber: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var btnPlay: UIBarButtonItem!
    
    var isPlaying = false
    
    //we need to create an instance of AVAudioPlayer
    var player = AVAudioPlayer()
    
    //we need to access audio file path
    let path = Bundle.main.path(forResource: "bach", ofType: "mp3")
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            scrubber.maximumValue = Float(player.duration)
        } catch {
            print(error)
        }
        
    }

    @IBAction func playAudio(_ sender: UIBarButtonItem) {
        if isPlaying {
            btnPlay.image = UIImage(systemName: "play.fill")
            player.pause()
            isPlaying = false
            timer.invalidate()
        }
        else {
            
            btnPlay.image = UIImage(systemName: "pause.fill")
            player.play()
            isPlaying = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateScrubber), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateScrubber(){
        scrubber.value = Float(player.currentTime)
        if scrubber.value == scrubber.minimumValue {
            isPlaying = false
            btnPlay.image = UIImage(systemName: "play.fill")
        }
    }
    
    @IBAction func scrubberMoved(_ sender: UISlider) {
        player.currentTime = TimeInterval(scrubber.value)
        if isPlaying{
            player.play()
        }
    }
    
    
}

