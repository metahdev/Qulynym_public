/*
* Kulynym
* StoryPresenter.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol StoryPresenterProtocol: class {
    func getMaxCount()
    func playAudio()
    func stopAudio()
    func playNext()
    func playPrevious()
    func closeView()
}

class StoryPresenter: StoryPresenterProtocol {
    // MARK:- Properties
    weak var controller: StoryViewControllerProtocol!
    var router: StoryRouterProtocol!
    var interactor: StoryInteractorProtocol!
    
    required init(_ controller: StoryViewControllerProtocol) {
        self.controller = controller
    }
}

extension StoryPresenter {
    // MARK:- Protocol Methods
    func getMaxCount() {
        controller.maxCount = interactor.getMaxCount()
    }
    
    func playAudio() {
        if !AudioPlayer.storyPlayerInitied {
            AudioPlayer.setupExtraAudio(with: controller.storyName, audioPlayer: .story)
        }
        AudioPlayer.backgroundAudioPlayer.stop()
        AudioPlayer.storyAudioPlayer.play()
    }
    
    func stopAudio() {
        AudioPlayer.storyAudioPlayer.stop()
        AudioPlayer.backgroundAudioPlayer.play()
    }
    
    func playNext() {
        controller.storyName = interactor.getNextVideo(&controller.index)
        updateForUser()
    }
    
    func playPrevious() {
        controller.storyName = interactor.getPreviousVideo(&controller.index)
        updateForUser()
    }
    
    private func updateForUser() {
        AudioPlayer.setupExtraAudio(with: controller.storyName, audioPlayer: .story)
        AudioPlayer.backgroundAudioPlayer.play()
    }
    
    func closeView() {
        router.close()
    }
}

