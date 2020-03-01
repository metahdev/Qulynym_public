/*
 * Qulynym
 * AudioPlayer.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import AVFoundation

enum PlayerType {
    case effects
    case content
    case question
    case story
    case song
}

struct AudioPlayer {
    // MARK:- Properties
    static var backgroundAudioStatePlaying = true 
    static var playlistPlayerInitiated = false
    
    static var audioQueue = DispatchQueue.global(qos: .userInteractive)
    
    static var backgroundAudioPlayer = AVAudioPlayer()
    static var sfxAudioPlayer = AVAudioPlayer()
    static var contentAudioPlayer = AVAudioPlayer()
    static var questionAudioPlayer = AVAudioPlayer()
    static var storyAudioPlayer = AVAudioPlayer()
    static var playlistItemAudioPlayer = AVAudioPlayer()
    
 
    // MARK:- Background Audio
    static func turnOnBackgroundMusic() {
        initBackgroundAudio()
        backgroundAudioPlayer.play()
    }
    
    private static func initBackgroundAudio() {
        let url = setupPaths(name: "backgroundAudio")
        initPlayers(player: &backgroundAudioPlayer, url: url)
        
        backgroundAudioPlayer.numberOfLoops = -1
        backgroundAudioPlayer.volume = 0.1
    }
    
    
    // MARK:- Extra Audios
    static func setupExtraAudio(with name: String, audioPlayer: PlayerType) {
        let url = setupPaths(name: name)
        switch audioPlayer {
        case .effects:
            initPlayers(player: &sfxAudioPlayer, url: url)
            sfxAudioPlayer.play()
        case .content:
            initPlayers(player: &contentAudioPlayer, url: url)
            contentAudioPlayer.volume = 1.5
        case .question:
            initPlayers(player: &questionAudioPlayer, url: url)
            questionAudioPlayer.volume = 1.5
        case .story:
            initPlayers(player: &storyAudioPlayer, url: url)
            playlistPlayerInitiated = true
        case .song:
            initPlayers(player: &playlistItemAudioPlayer, url: url)
            playlistPlayerInitiated = true 
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
            return 
        }
    }
}
