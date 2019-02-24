/*
 * Kulynym
 * File.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ItemPresenterProtocol: class {
    var view: ItemVCProtocol! { set get }
    var interactor: ItemInteractorProtocol! { set get }
    var router: ItemRouterProtocol! { set get }
    
    func updateView()
    func imageViewPressed()
    func closeBtnPressed()
}

class ItemPresenter: ItemPresenterProtocol {
    weak var view: ItemVCProtocol!
    var router: ItemRouterProtocol!
    var interactor: ItemInteractorProtocol!
    
    required init(view: ItemVCProtocol) {
        self.view = view
    }
}

extension ItemPresenter {
    func updateView() {
        view.contentKey = interactor.fillContent(with: view.slideCount, with: view.category)
        view.slideCount += 1
        view.setupContent()
    }
    
    func imageViewPressed() {
        AudioManager.extraAudioPlayer.play()
    }
    
    func closeBtnPressed() {
        router.closeView()
    }
}
