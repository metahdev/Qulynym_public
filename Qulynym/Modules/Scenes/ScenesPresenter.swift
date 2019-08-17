/*
* Qulynym
* ScenesPresenter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesPresenterProtocol: class {    
    func playAudio()
    func skipBtnPressed()
}

class ScenesPresenter: ScenesPresenterProtocol {
    // MARK:- Properties
    weak var controller: ScenesViewControllerProtocol!
    var interactor: ScenesInteractorProtocol!
    var router: ScenesRouterProtocol!
    
    required init(_ view: ScenesViewControllerProtocol) {
        self.controller = view
    }
}

extension ScenesPresenter {
    // MARK:- Protocol Methods
    func playAudio() {
        AudioPlayer.setupExtraAudio(with: controller.manager.instruction, audioPlayer: .scenes)
    }
    
    func skipBtnPressed() {
        AudioPlayer.scenesAudioPlayer.stop()
        router.closeView()
    }
}
