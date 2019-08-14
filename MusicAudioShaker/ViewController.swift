//
//  ViewController.swift
//  MusicAudioShaker
//
//  Created by IMCS2 on 8/8/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var songArray = ["simba","chasma","firstSong", "guru", "humpty","kar","malhari","queen","Zingaat","OldTown"]
    
    var count = 0
    
    @IBOutlet weak var songNameLabel: UILabel!
    
    var player = AVAudioPlayer()

    @IBAction func playAction(_ sender: Any) {
        playMusic()
        player.play()
        
    }
    
    
    @IBAction func pauseAction(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func volumeSlider(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    
    @IBOutlet weak var volumeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        let swipRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipped(gesture: )))
        
        swipRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipRight)
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipped(gesture: )))
        
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        
        
    }
    
    @objc func swipped(gesture : UISwipeGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .right {
                print("Swipped right")
                print(count)
                if count < 8{
                    count = count + 1
                playMusic()
                player.play()
                } else {
                    count = 9
                    playMusic()
                    player.play()
                }
                
                
            }else {
                
                print("Swipped left")
                
                count = count - 1
                if count > 0 {
                playMusic()
                player.play()
                } else {
                    count = 0
                    playMusic()
                    player.play()
                }
            }
        }
    }
    
    func playMusic() {
        
        let audioPath = Bundle.main.path(forResource: songArray[count], ofType: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            songNameLabel.text = songArray[count]
        } catch {
            print("error")
        }
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            print("device was shaked")
            var number = Int.random(in: 0 ..< 10)
            count = number
            playMusic()
            player.play()
        }
        
    }

}

