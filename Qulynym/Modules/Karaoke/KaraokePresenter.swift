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
    var timer: TimerController! { get }
    
    func getMaxCount()
    func getLyricsText()
    func getTextViewTimepoints() 
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
    
    var timer: TimerController!
    var timepoints: [Int: Int]!
    
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
    
    func getTextViewTimepoints() {
        timepoints = interactor.getTextViewTimepoints(controller.index)
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
        controller.setTimelineSliderMaxValue()
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
        AudioPlayer.karaokeAudioPlayer.pause()
        controller.setTimelineSliderValue(Int(value))
        let previousValue = timer.seconds
        timer.seconds = Int(value)
        if previousValue < timer.seconds {
            timer.checkForForwardScroll()
        } else {
            timer.checkForRewindScroll()
        }
        AudioPlayer.karaokeAudioPlayer.currentTime = TimeInterval(exactly: value)!
        AudioPlayer.karaokeAudioPlayer.prepareToPlay()
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
    
    func notifyOfSecondPassed() {
        controller.setTimelineSliderValue(timer!.seconds)
    }
    
    func notifyOfTimepoints() {
        controller.scrollTextView(to: self.timepoints[timer.timepoint!]!)
    }
    
    func notifyTimerEnded() {
        AudioPlayer.karaokeAudioPlayer.currentTime = TimeInterval(exactly: 0.0)!
    }
}
