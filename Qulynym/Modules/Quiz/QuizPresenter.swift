/*
 * Qulynym
 * QuizPresenter.swift
 *
 * Created by: Metah on 7/31/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol QuizPresenterProtocol: class {
    func setCards()
    func getRandom()
    func playAudio()
    func deleteItem()
    func closeView()
    func backToItemWithRepeat()
}

class QuizPresenter: QuizPresenterProtocol {
    // MARK:- Properites
    weak var controller: QuizViewControllerProtocol!
    var interactor: QuizInteractorProtocol!
    var router: QuizRouterProtocol!
    private var modifiedCards = [String]()
    
    
    // MARK:- Initialization
    required init(_ view: QuizViewControllerProtocol) {
        self.controller = view
    }
}

extension QuizPresenter {
    // MARK:- Protocol Methods
    func setCards() {
        modifiedCards = controller.cards
    }
    
    func getRandom() {
        controller.randomCard = modifiedCards[Int.random(in: 0...modifiedCards.count - 1)]
    }
    
    func playAudio() {
        if modifiedCards.count == 1 {
            return
        }
        
        controller.changeViewsEnableState(enable: false)
        AudioPlayer.audioQueue.async {
            // *** asyncAfter
            while AudioPlayer.sfxAudioPlayer.isPlaying {}
            AudioPlayer.questionAudioPlayer.play()
            while AudioPlayer.questionAudioPlayer.isPlaying {}
            AudioPlayer.contentAudioPlayer.play()
            DispatchQueue.main.async {
                self.controller.changeViewsEnableState(enable: true)
            }
        }
    }
    
    func deleteItem() {
        if modifiedCards.count == 1 {
            AudioPlayer.audioQueue.async {
                while AudioPlayer.sfxAudioPlayer.isPlaying {}
                DispatchQueue.main.async {
                    self.router.backToItem(didPass: true)
                }
            }
            return
        }
        
        removePreviousCard()
        getRandom()
        controller.shuffleCards()
    }
    
    private func removePreviousCard() {
        let index = modifiedCards.firstIndex(of: controller.randomCard)
        modifiedCards.remove(at: index!)
    }
    
    func closeView() {
        stopAudios()
        router.close(showCongratulationsScenes: false)
    }
    
    func backToItemWithRepeat() {
        stopAudios()
        controller.changeViewsEnableState(enable: false)
        AudioPlayer.audioQueue.async {
            AudioPlayer.setupExtraAudio(with: "tryAgain", audioPlayer: .effects)
            while AudioPlayer.sfxAudioPlayer.isPlaying {}
            DispatchQueue.main.async {
                self.controller.changeSelectedCellOpacity(to: 1.0)
                self.router.backToItem(didPass: false)
            }
        }
    }
    
    private func stopAudios() {
        AudioPlayer.questionAudioPlayer.stop()
        AudioPlayer.contentAudioPlayer.stop()
    }
}
