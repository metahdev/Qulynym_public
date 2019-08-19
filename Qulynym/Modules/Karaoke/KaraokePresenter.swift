//
/*
* Kulynym
* KaraokePresenter.swift
*
* Created by: Metah on 8/4/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol KaraokePresenterProtocol: class {
    var duration: TimeInterval { get }
    
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

class KaraokePresenter: KaraokePresenterProtocol {
    weak var controller: KaraokeViewControllerProtocol!
    var interactor: KaraokeInteractorProtocol!
    var router: KaraokeRouterProtocol!
    
    private var timer: TimerController!
    
    required init(_ controller: KaraokeViewControllerProtocol) {
        self.controller = controller
    }
}

extension KaraokePresenter {
    // MARK:- Protocol Methods
    func getMaxCount() {
        controller.maxIndex = interactor.getMaxCount(controller.isKaraoke)
    }
    
    func getLyricsText() {
        controller.lyricsText = interactor.getLyricsText(controller.index)
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
        AudioPlayer.karaokeAudioPlayer.play()
        timer.startTimer()
    }
    
    func pauseAudio() {
        timer.timer?.invalidate()
        timer.timer = nil
        AudioPlayer.karaokeAudioPlayer.pause()
        if AudioPlayer.backgroundAudioStatePlaying {
            AudioPlayer.backgroundAudioPlayer.play()
        }
    }
    
    func backToPreviousAudio() {
        controller.contentName = interactor.getPreviousAudioName(&controller.index, isKaraoke: controller.isKaraoke)
        timer.nullifyData()
        if controller.isPlaying {
            controller.playBtnPressed()
        }
        updateForUser()
    }
    
    func nextAudio() {
        controller.contentName = interactor.getNextAudioName(&controller.index, isKaraoke: controller.isKaraoke)
        timer.nullifyData()
        controller.playBtnPressed()
        if controller.isPlaying {
            controller.playBtnPressed()
        }
        updateForUser()
    }
    
    private func updateForUser() {
        timer.nullifyData()
        controller.checkTimelineSliderValue(0)
        AudioPlayer.playlistPlayerInitiated = false
        getLyricsText()
        controller.setViewsProperties()
    }
    
    func scrollAudio(to value: Float) {
        AudioPlayer.karaokeAudioPlayer.pause()
        controller.checkTimelineSliderValue(Int(value))
        timer.seconds = Int(value)
        AudioPlayer.karaokeAudioPlayer.currentTime = TimeInterval(exactly: value)!
        AudioPlayer.karaokeAudioPlayer.play()
    }
    
    func changeAudioVolume(to value: Float) {
        AudioPlayer.karaokeAudioPlayer.volume = value
    }
    
    func close() {
        AudioPlayer.playlistPlayerInitiated = false
        timer.nullifyData()
        router.close()
    }
}

extension KaraokePresenter: TimerControllerDelegate {
    var duration: TimeInterval {
        get {
            return AudioPlayer.karaokeAudioPlayer.duration
        }
    }
    
    func notifyOfTimepoints() {
        controller.checkTimelineSliderValue(timer!.seconds)
    }
    
    func notifyTimerEnded() {
    }
}
