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
    func stopAudio()
    func backToPreviousAudio()
    func nextAudio()
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
    
    func stopAudio() {
        AudioPlayer.karaokeAudioPlayer.stop()
        AudioPlayer.backgroundAudioPlayer.play()
    }
    
    func backToPreviousAudio() {
        controller.contentName = interactor.getPreviousAudioName(&controller.index)
        updateForUser()
    }
    
    func nextAudio() {
        controller.contentName = interactor.getNextAudioName(&controller.index)
        updateForUser()
    }
    
    private func updateForUser() {
        AudioPlayer.karaokeAudioPlayer.stop() 
        AudioPlayer.playlistPlayerInitiated = false
        getLyricsText()
        controller.setViewsProperties()
    }
    
    func close() {
        AudioPlayer.playlistPlayerInitiated = false
        router.close()
    }
}
