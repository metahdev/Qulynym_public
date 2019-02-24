/*
 * Kulynym
 * File.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import AVFoundation

struct AudioManager {
    static var backgroundAudioPlayer = AVAudioPlayer()
    static var extraAudioPlayer = AVAudioPlayer()
    
    static func turnOnBackgroundMusic() {
        let filePath = Bundle.main.path(forResource: "backgroundAudio", ofType: "mp3")
        let url = URL.init(fileURLWithPath: filePath!)
        
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print(error)
        }
        
        backgroundAudioPlayer.numberOfLoops = -1
        backgroundAudioPlayer.volume = 0.5
        
        backgroundAudioPlayer.play()
    }
    
    static func initExtraAudioPath(with name: String) {
        let filePath = Bundle.main.path(forResource: name, ofType: "mp3")
        let url = URL.init(fileURLWithPath: filePath!)
        
        do {
            extraAudioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print(error)
        }
    }
}
