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
    
    func getSlideCount() 
    func updateView(forward: Bool?)
    func getAreImagesTransparentInfo()
    func contentBtnPressed()
    func closeBtnPressed()
}

class ItemPresenter: ItemPresenterProtocol {
    // MARK:- Properties
    var slideCount = 0
    var contentKey = ""
    var openedQuiz = false
    
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
    func getSlideCount() {
        interactor.getSlideCount(section: controller.section.name)
    }
    
    func updateView(forward: Bool?) {
        if openedQuiz {
            return
        }
        
        updateProperties(forward)
        
        guard !openedQuiz else {
            let count = slideCount
            passDataAndOpenQuiz(with: count)
            return
        }
        
        controller.returnedFromQuiz = false
        AudioPlayer.setupExtraAudio(with: contentKey, audioPlayer: .content)
        AudioPlayer.contentAudioPlayer.play()
        controller.updateContent(contentKey: contentKey)
    }
    
    func getAreImagesTransparentInfo() {
        if controller.section.name == "Zhanuarlar" || controller.section.name == "O'simdikter" {
            controller.areImagesTransparent = false
        }
    }
    
    func updateProperties(_ forward: Bool?) {
        guard let forward = forward else {
            self.contentKey = controller.section.contentNames[self.slideCount]
            return
        }
        if forward {
            self.slideCount += 1
        } else {
            self.slideCount -= 1
        }
        
        if slideCount % 4 == 0 && slideCount != 0 && !controller.returnedFromQuiz {
            openedQuiz = true
        } else {
            self.contentKey = controller.section.contentNames[self.slideCount]
        }
    }
    
    private func passDataAndOpenQuiz(with count: Int) {
        let shuffledCards = interactor.getShuffledCards(from: controller.section.contentNames)
        router.openQuiz(shuffledCards, with: controller.section.name, and: count)
    }
    
    func contentBtnPressed() {
        AudioPlayer.contentAudioPlayer.play()
    }
    
    func closeBtnPressed() {
        router.closeView()
    }
}
