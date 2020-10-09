 /*
* Qulynym
* PlaylistItemPresenter.swift
*
* Created by: Metah on 8/4/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
 */

import Foundation

protocol PlaylistItemPresenterProtocol: class {
    var duration: TimeInterval { get }
    var timer: TimerController! { get }
    
    func getMaxCount()
    func getLyricsText()
    func initTimer()
    func playAudio()
    func pauseAudio()
    func backToPreviousAudio()
    func nextAudio()
    func scrollAudio(to value: Float)
    func changeAudioVolume(to value: Float)
    func close()
}

class PlaylistItemPresenter: PlaylistItemPresenterProtocol {
    weak var controller: PlaylistItemViewControllerProtocol!
    var interactor: PlaylistItemInteractorProtocol!
    var router: PlaylistItemRouterProtocol!
    
    var timer: TimerController!
    private var ended = false
    
    required init(_ controller: PlaylistItemViewControllerProtocol) {
        self.controller = controller
    }
}

extension PlaylistItemPresenter {
    // MARK:- Protocol Methods
    func getMaxCount() {
        controller.maxIndex = interactor.getMaxCount(controller.isKaraoke)
    }
    
    func getLyricsText() {
        if controller.isKaraoke {
            controller.lyricsText = interactor.getLyricsText(controller.index)
        }
    }
    
    func initTimer() {
        timer = TimerController()
        timer.delegate = self
    }
    
    func playAudio() {
        if !AudioPlayer.playlistPlayerInitiated {
            AudioPlayer.setupExtraAudio(with: controller.contentName, audioPlayer: .song)
        }
        AudioPlayer.backgroundAudioPlayer.stop()
        AudioPlayer.playlistItemAudioPlayer.play()
        timer.startTimer()
        controller.setTimelineSliderMaxValue()
    }
    
    func pauseAudio() {
        timer.timer?.invalidate()
        timer.timer = nil
        AudioPlayer.playlistItemAudioPlayer.pause()
    }
    
    func backToPreviousAudio() {
        controller.contentName = interactor.getPreviousAudioName(&controller.index, isKaraoke: controller.isKaraoke)
        updateForUser()
        if controller.isPlaying {
            controller.playBtnPressed()
        }
        controller.playBtnPressed()
    }
    
    func nextAudio() {
        controller.contentName = interactor.getNextAudioName(&controller.index, isKaraoke: controller.isKaraoke)
        updateForUser()
        if controller.isPlaying {
            controller.playBtnPressed()
        }
        controller.playBtnPressed()
    }
    
    private func updateForUser() {
        timer.nullifyData()
        controller.setTimelineSliderValue(0)
        updateStates()
        AudioPlayer.playlistPlayerInitiated = false
        
        if controller.isKaraoke {
            getLyricsText()
            controller.currentLine = 0
            controller.scrollToCurrentLine()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.controller.setViewsProperties()
        })
    }
    
    func scrollAudio(to value: Float) {
        if controller.isKaraoke {
            controller.clearLine()
            findCurrentLine(value)
        }
        AudioPlayer.playlistItemAudioPlayer.pause()
        controller.setTimelineSliderValue(value)
        timer.counter = value
        AudioPlayer.playlistItemAudioPlayer.currentTime = TimeInterval(exactly: value)!
        AudioPlayer.playlistItemAudioPlayer.prepareToPlay()
        AudioPlayer.playlistItemAudioPlayer.play()
    }
    
    private func findCurrentLine(_ value: Float) {
        let song = Content.songs[controller.index]
        var index = 0
        var line = 0
        ended = false
        
        for timestop in song.timestops {
            if timestop.0 < value {
                line = index
            } else {
                guard index != 0 else {
                    startAgain(value)
                    return
                }
                controller.began = true
                if song.timestops[line].1 > value {
                    controller.currentLine = line
                    controller.updateCurrentLine()
                    return
                } else {
                    controller.currentLine = line + 1
                    controller.highlighting = false
                }
                controller.scrollToCurrentLine()
                break
            }
            index += 1
        }
    }
    
    private func startAgain(_ value: Float) {
        let song = Content.songs[controller.index]
        controller.currentLine = 0
        controller.highlighting = false
        controller.scrollToCurrentLine()
        if song.timestops[0].1 > value && song.timestops[0].0 < value {
            controller.updateCurrentLine()
        }
    }
    
    func changeAudioVolume(to value: Float) {
        AudioPlayer.playlistItemAudioPlayer.volume = value
    }
    
    func close() {
        AudioPlayer.playlistPlayerInitiated = false
        AudioPlayer.playlistItemAudioPlayer.stop()
        if AudioPlayer.backgroundAudioStatePlaying {
            AudioPlayer.backgroundAudioPlayer.play()
        }
        timer.nullifyData()
        router.close()
    }
}

extension PlaylistItemPresenter: TimerControllerDelegate {    
    var duration: TimeInterval {
        get {
            return AudioPlayer.playlistItemAudioPlayer.duration
        }
    }
    
    func notifyOfMillisecondPassed() {
        controller.setTimelineSliderValue(Float(timer!.counter))
        
        let song = Content.songs[controller.index]
        guard !ended else {
            return
        }
        guard controller.isKaraoke else {
            return
        }
        if timer!.counter == song.timestops[controller.currentLine].0 {
            controller.highlighting = true
            controller.updateCurrentLine()
        }
        if timer!.counter == song.timestops[controller.currentLine].1 {
            controller.clearLine()
            if controller.currentLine == song.timestops.count - 1 {
                self.ended = true
                controller.scrollToCurrentLine()
                return
            }
            controller.currentLine += 1
            controller.highlighting = false 
            controller.scrollToCurrentLine()
        }
    }
    
    func notifyTimerEnded() {
        controller.currentLine = 0
        controller.scrollToCurrentLine()
        updateStates()
        AudioPlayer.playlistItemAudioPlayer.currentTime = TimeInterval(exactly: 0.0)!
    }
    
    private func updateStates() {
        self.ended = false
        controller.began = false
        controller.highlighting = false
    }
}
