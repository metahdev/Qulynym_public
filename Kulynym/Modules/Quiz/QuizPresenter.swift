/*
* Kulynym
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
    func playGoodJobAudio()
    func playTryAgainAudio()
    func deleteItem()
    func closeView()
    func backToItemWithRepeat()
}

class QuizPresenter: QuizPresenterProtocol {
    // MARK:- Properites
    weak var view: QuizViewControllerProtocol!
    var interactor: QuizInteractorProtocol!
    var router: QuizRouterProtocol!
    private var modifiedCards = [String]()
    
    
    // MARK:- Initialization
    required init(_ view: QuizViewControllerProtocol) {
        self.view = view
    }
}

extension QuizPresenter {
    // MARK:- Protocol Methods
    func setCards() {
        modifiedCards = view.cards
    }
    
    func getRandom() {
        view.randomCard = modifiedCards[Int.random(in: 0...modifiedCards.count - 1)]
    }
    
    func playAudio() {
        AudioPlayer.questionAudioPlayer.play()
        while AudioPlayer.questionAudioPlayer.isPlaying {}
        AudioPlayer.contentAudioPlayer.play()
    }
    
    func playGoodJobAudio() {
        
    }
    
    func playTryAgainAudio() {
        
    }
    
    func deleteItem() {
        if modifiedCards.count == 1 {
            router.backToItem(didPass: true)
            return
        }
        let index = modifiedCards.firstIndex(of: view.randomCard)
        modifiedCards.remove(at: index!)
        getRandom()
        view.shuffleCards()
        playAudio()
    }
    
    func closeView() {
        router.close() 
    }
    
    func backToItemWithRepeat() {
        router.backToItem(didPass: false)
    }
}
