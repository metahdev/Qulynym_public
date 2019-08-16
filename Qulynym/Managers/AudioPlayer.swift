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
    case effects
    case scenes
    case content
    case question
    case story
    case song
}

struct AudioPlayer {
    // MARK:- Properties
    static var playlistPlayerInitiated = false
    
    static var backgroundAudioPlayer = AVAudioPlayer()
    static var sfxAudioPlayer = AVAudioPlayer()
    static var contentAudioPlayer = AVAudioPlayer()
    static var scenesAudioPlayer = AVAudioPlayer()
    static var questionAudioPlayer = AVAudioPlayer()
    static var storyAudioPlayer = AVAudioPlayer()
    static var karaokeAudioPlayer = AVAudioPlayer()
    
    
    // MARK: Background Audio
    static func turnOnBackgroundMusic() {
        initBackgroundAudio()
        backgroundAudioPlayer.play()
    }
    
    private static func initBackgroundAudio() {
        let url = setupPaths(name: "backgroundAudio")
        initPlayers(player: &backgroundAudioPlayer, url: url)
        
        backgroundAudioPlayer.numberOfLoops = -1
        backgroundAudioPlayer.volume = 0.5
    }
    
    
    // MARK:- Extra Audios
    static func setupExtraAudio(with name: String, audioPlayer: PlayerType) {
        let url = setupPaths(name: name)
        switch audioPlayer {
        case .effects:
            initPlayers(player: &sfxAudioPlayer, url: url)
            sfxAudioPlayer.play()
        case .scenes:
            initPlayers(player: &scenesAudioPlayer, url: url)
            scenesAudioPlayer.play()
        case .content:
            initPlayers(player: &contentAudioPlayer, url: url)
        case .question:
            initPlayers(player: &questionAudioPlayer, url: url)
        case .story:
            initPlayers(player: &storyAudioPlayer, url: url)
            playlistPlayerInitiated = true
        case .song:
            initPlayers(player: &karaokeAudioPlayer, url: url)
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
            print("unresolver error: \(error)")
        }
    }
}