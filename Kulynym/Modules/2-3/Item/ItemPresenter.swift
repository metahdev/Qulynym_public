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
    var slideCount = 0
    var contentKey = ""
    
    weak var view: ItemVCProtocol!
    var router: ItemRouterProtocol!
    var interactor: ItemInteractorProtocol!
    
    required init(view: ItemVCProtocol) {
        self.view = view
    }
}

extension ItemPresenter {
    func updateView() {
        updateProperties()
        AudioPlayer.turnOnExtraAudio(with: contentKey, audioPlayer: .content)
        view.updateContent(contentKey: contentKey)
    }
    
    func updateProperties() {
        self.contentKey = interactor.fillContent(with: self.slideCount, with: view.category)
        self.slideCount += 1
    }
    
    func contentBtnPressed() {
        AudioPlayer.contentAudioPlayer.play()
    }
    
    func closeBtnPressed() {
        router.closeView()
    }
}
