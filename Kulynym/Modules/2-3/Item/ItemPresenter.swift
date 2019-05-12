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
    
    weak var view: ItemVCProtocol!
    var router: ItemRouterProtocol!
    var interactor: ItemInteractorProtocol!
    
    required init(view: ItemVCProtocol) {
        self.view = view
    }
}

extension ItemPresenter {
    // MARK:- Protocol Methods
    func updateView() {
        updateProperties()
        AudioPlayer.setupExtraAudio(with: contentKey, audioPlayer: .content)
        view.updateContent(contentKey: contentKey)
    }
    
    func updateProperties() {
        self.contentKey = interactor.fillContent(with: self.slideCount, with: view.contentNames)
        self.slideCount += 1
    }
    
    func contentBtnPressed() {
        AudioPlayer.queue.async {
            AudioPlayer.contentAudioPlayer.play()
        }
    }
    
    func closeBtnPressed() {
        router.closeView()
    }
}
