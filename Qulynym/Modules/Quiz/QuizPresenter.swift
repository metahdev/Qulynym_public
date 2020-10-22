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
    
    weak var moduleOuput: QuizModuleOutput?
    
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
        AudioPlayer.audioQueue.async {
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
            if controller.itemView.slideCount == controller.itemView.section.contentNames.count {
                AudioPlayer.setupExtraAudio(with: "cheers", audioPlayer: .question)
                AudioPlayer.questionAudioPlayer.play()
                controller.animateConfetti()
                self.interactor.saveData(slide: self.controller.count, category: self.controller.categoryName)
                self.router.returnToMenu()
                return
            }
            AudioPlayer.audioQueue.async {
                while AudioPlayer.sfxAudioPlayer.isPlaying {}
                DispatchQueue.main.async {
                    self.interactor.saveData(slide: self.controller.count, category: self.controller.categoryName)
                    self.moduleOuput?.quizModuleOutputDidFinishQuiz(isSuccessful: true)
                    self.router.close()
                }
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
        self.moduleOuput?.quizModuleOutputDidFinishQuiz(isSuccessful: false)
    }
    
    func stopAudios() {
        AudioPlayer.questionAudioPlayer.stop()
        AudioPlayer.contentAudioPlayer.stop()
    }
}
