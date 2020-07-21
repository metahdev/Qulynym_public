/*
 * Qulynym
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
    var openedQuiz: Bool { get set }
    var isForwardTapped: Bool { get set }
    
    func updateView()
    func returnBack()
    func getAreImagesTransparentInfo()
    func contentBtnPressed()
    func closeBtnPressed()
}

class ItemPresenter: ItemPresenterProtocol {
    // MARK:- Properties
    var slideCount = 0
    var contentKey = ""
    var openedQuiz = false
    var isForwardTapped = false
    
    weak var controller: ItemViewControllerProtocol!
    var router: ItemRouterProtocol!
    var interactor: ItemInteractorProtocol!
    
    
    // MARK:- Initialization
    required init(_ controller: ItemViewControllerProtocol) {
        self.controller = controller
    }
}

extension ItemPresenter {
    // MARK:- Protocol Methods
    func updateView() {
        isForwardTapped = true
        
        if openedQuiz {
            return
        }
        
        if slideCount % 4 == 0 && slideCount != 0 && !controller.returnedFromQuiz {
            passDataAndOpenQuiz()
            openedQuiz = true
            return
        }
        
        controller.returnedFromQuiz = false
        updateProperties()
        AudioPlayer.setupExtraAudio(with: contentKey, audioPlayer: .content)
        AudioPlayer.contentAudioPlayer.play()
        controller.updateContent(contentKey: contentKey)
    }
    
    func returnBack() {
        isForwardTapped = false
        
        if openedQuiz {
            return
        }
        
        updateProperties()
        AudioPlayer.setupExtraAudio(with: contentKey, audioPlayer: .content)
        AudioPlayer.contentAudioPlayer.play()
        controller.updateContent(contentKey: contentKey)
    }
    
    func getAreImagesTransparentInfo() {
        if controller.section.name == "Zhanuarlar" || controller.section.name == "O'simdikter" {
            controller.areImagesTransparent = false
        }
    }
    
    func updateProperties() {
        self.contentKey = interactor.fillContent(with: self.slideCount, with: controller.section.contentNames)
        if isForwardTapped {
            self.slideCount += 1
        } else {
            self.slideCount -= 1
        }
    }
    
    private func passDataAndOpenQuiz() {
        let shuffledCards = interactor.getShuffledCards(from: controller.section.contentNames)
        router.openQuiz(shuffledCards, with: controller.section.name)
    }
    
    func contentBtnPressed() {
        AudioPlayer.contentAudioPlayer.play()
    }
    
    func closeBtnPressed() {
        router.closeView()
    }
}
