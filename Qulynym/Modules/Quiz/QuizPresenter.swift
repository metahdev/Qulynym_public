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
    func stopAudios()
}

class QuizPresenter: QuizPresenterProtocol {
    // MARK:- Properites
    weak var controller: QuizViewControllerProtocol!
    var interactor: QuizInteractorProtocol!
    var router: QuizRouterProtocol!
    var modifiedCards = [String]()
    
    private var sfxDuration: TimeInterval {
        return AudioPlayer.sfxAudioPlayer.duration
    }
    private var questionDuration: TimeInterval {
        return AudioPlayer.questionAudioPlayer.duration
    }
    
    
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
        controller.changeViewsEnableState(enable: false)
        let delay = AudioPlayer.sfxAudioPlayer.isPlaying ? sfxDuration : 0.0
        AudioPlayer.audioQueue.asyncAfter(deadline: .now() + delay, execute: {
            AudioPlayer.questionAudioPlayer.play()
    
            DispatchQueue.main.asyncAfter(deadline: .now() + self.questionDuration, execute: {
                AudioPlayer.contentAudioPlayer.play()
                self.controller.changeViewsEnableState(enable: true)
            })
        })
    }
    
    func deleteItem() {
        if modifiedCards.count == 1 {
            if controller.itemView.slideCount == controller.itemView.section.contentNames.count {
                AudioPlayer.setupExtraAudio(with: "cheers", audioPlayer: .question)
                AudioPlayer.questionAudioPlayer.play()
                controller.animateConfetti()
                self.interactor.saveData(slide: self.controller.count, category: self.controller.categoryName)
                self.router.returnToMenu()
                return
            }
            AudioPlayer.audioQueue.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + self.sfxDuration, execute: {
                    self.interactor.saveData(slide: self.controller.count, category: self.controller.categoryName)
                    self.router.backToItem(didPass: true)
                })
            }
            return
        }
        
        playAudio() 
        removePreviousCard()
        getRandom()
        controller.shuffleCards()
    }
    
    func removePreviousCard() {
        let index = modifiedCards.firstIndex(of: controller.randomCard)
        modifiedCards.remove(at: index!)
    }
    
    func closeView() {
        stopAudios()
        router.close()
    }
    
    func backToItemWithRepeat() {
        self.router.backToItem(didPass: false)
    }
    
    func stopAudios() {
        AudioPlayer.questionAudioPlayer.stop()
        AudioPlayer.contentAudioPlayer.stop()
    }
}
