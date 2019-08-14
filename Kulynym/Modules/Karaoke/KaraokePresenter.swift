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
    func getMaxCount()
    func getLyricsText()
    func playAudio()
    func pauseAudio()
    func backToPreviousAudio()
    func nextAudio()
    func scrollAudio(to value: Float)
    func close()
}

class KaraokePresenter: KaraokePresenterProtocol {
    weak var controller: KaraokeViewControllerProtocol!
    var interactor: KaraokeInteractorProtocol!
    var router: KaraokeRouterProtocol!
    
    required init(_ controller: KaraokeViewControllerProtocol) {
        self.controller = controller
    }
}

extension KaraokePresenter {
    // MARK:- Protocol Methods
    func getMaxCount() {
        controller.maxIndex = interactor.getMaxCount()
    }
    
    func getLyricsText() {
        controller.lyricsText = interactor.getLyricsText(controller.index)
    }
    
    func playAudio() {
        if !AudioPlayer.playlistPlayerInitiated {
            AudioPlayer.setupExtraAudio(with: controller.contentName, audioPlayer: .song)
        }
        AudioPlayer.backgroundAudioPlayer.stop()
        AudioPlayer.karaokeAudioPlayer.play()
    }
    
    func pauseAudio() {
        AudioPlayer.karaokeAudioPlayer.pause()
        AudioPlayer.backgroundAudioPlayer.play()
    }
    
    func backToPreviousAudio() {
        controller.contentName = interactor.getPreviousAudioName(&controller.index)
        updateForUser()
        controller.playBtnPressed()
    }
    
    func nextAudio() {
        controller.contentName = interactor.getNextAudioName(&controller.index)
        updateForUser()
        controller.playBtnPressed()
    }
    
    private func updateForUser() {
        AudioPlayer.backgroundAudioPlayer.play()
        AudioPlayer.playlistPlayerInitiated = false
        getLyricsText()
        controller.setViewsProperties()
    }
    
    func scrollAudio(to value: Float) {
        AudioPlayer.karaokeAudioPlayer.pause()
        let secondInPoint = AudioPlayer.karaokeAudioPlayer.duration / TimeInterval(exactly: Float(100.0))!
        AudioPlayer.karaokeAudioPlayer.currentTime = secondInPoint * TimeInterval(exactly: value)!
        AudioPlayer.karaokeAudioPlayer.play()
    }
    
    func close() {
        AudioPlayer.playlistPlayerInitiated = false
        router.close()
    }
}
