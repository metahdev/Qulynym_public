/*
 * Kulynym
 * ItemPresenter.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ItemPresenterProtocol: class {
    var slideCount: Int { get set }
    var contentKey: String { get set }
    
    func updateView()
    func contentBtnPressed()
    func closeBtnPressed()
}

class ItemPresenter: ItemPresenterProtocol {
    // MARK:- Properties
    var slideCount = 0
    var contentKey = ""
    
    weak var controller: ItemViewControllerProtocol!
    var router: ItemRouterProtocol!
    var interactor: ItemInteractorProtocol!
    
    required init(_ controller: ItemViewControllerProtocol) {
        self.controller = controller
    }
}

extension ItemPresenter {
    // MARK:- Protocol Methods
    func updateView() {
        updateProperties()
        AudioPlayer.setupExtraAudio(with: contentKey, audioPlayer: .content)
        controller.updateContent(contentKey: contentKey)
    }
    
    func updateProperties() {
        if slideCount % 4 == 0 && controller.checkForQuiz {
            passDataAndOpenQuiz()
            return
        }
        self.contentKey = interactor.fillContent(with: self.slideCount, with: controller.contentNames)
        self.slideCount += 1
        controller.checkForQuiz = true
    }
    
    private func passDataAndOpenQuiz() {
        let shuffledCards = interactor.getShuffledCards(from: controller.contentNames)
        router.openQuiz(shuffledCards, with: controller.categoryName)
    }
    
    func contentBtnPressed() {
        AudioPlayer.contentAudioPlayer.play()
    }
    
    func closeBtnPressed() {
        router.closeView()
    }
}
