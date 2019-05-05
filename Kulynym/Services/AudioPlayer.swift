/*
 * Kulynym
 * AudioPlayer.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import AVFoundation

enum PlayerType {
    case scenes
    case content
}

struct AudioPlayer {
    static var backgroundAudioPlayer = AVAudioPlayer()
    static var contentAudioPlayer = AVAudioPlayer()
    static var scenesAudioPlayer = AVAudioPlayer()
    
    static func turnOnBackgroundMusic() {
        let filePath = Bundle.main.path(forResource: "backgroundAudio", ofType: "mp3")
        let url = URL.init(fileURLWithPath: filePath!)
        
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("unresolved error \(error)")
        }
        
        backgroundAudioPlayer.numberOfLoops = -1
        backgroundAudioPlayer.volume = 0.5
        
        backgroundAudioPlayer.play()
    }
    
    static func initExtraAudioPath(with name: String, audioPlayer: PlayerType) {
        let url = setupPaths(name: name)
        switch audioPlayer {
        case .scenes:
            initPlayers(player: &scenesAudioPlayer, url: url)
        case .content:
            initPlayers(player: &contentAudioPlayer, url: url)
        }
    }
    
    private static func setupPaths(name: String) -> URL {
        let filePath = Bundle.main.path(forResource: name, ofType: "mp3")
        let url = URL.init(fileURLWithPath: filePath!)
        return url
    }
    
    private static func initPlayers(player: inout AVAudioPlayer, url: URL) {
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("unresolver error: \(error)")
        }
    }
    
    static func playScenesAudio() {
        backgroundAudioPlayer.stop()
        scenesAudioPlayer.play()
    }
}
