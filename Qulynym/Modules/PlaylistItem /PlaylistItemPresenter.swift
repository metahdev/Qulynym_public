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
        AudioPlayer.playlistPlayerInitiated = false
        getLyricsText()
        controller.setViewsProperties()
    }
    
    func scrollAudio(to value: Float) {
        AudioPlayer.playlistItemAudioPlayer.pause()
        controller.setTimelineSliderValue(value)
        timer.counter = Double(value)
        AudioPlayer.playlistItemAudioPlayer.currentTime = TimeInterval(exactly: value)!
        AudioPlayer.playlistItemAudioPlayer.prepareToPlay()
        AudioPlayer.playlistItemAudioPlayer.play()
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
    }
    
    func notifyOfSecondPassed() {
//        let song = ContentService.songs[controller.index]
//        if Int(timer!.counter) == song.timestops[controller.currentLine].0 {
//            controller.updateCurrentLine()
//            controller.currentLine += 1
//        }
//        if Int(timer!.counter) == song.timestops[controller.currentLine].1 {
//            controller.clearPrevLine()
//            controller.scrollToNextLine()
//        }
    }
    
    func notifyTimerEnded() {
        AudioPlayer.playlistItemAudioPlayer.currentTime = TimeInterval(exactly: 0.0)!
    }
}
