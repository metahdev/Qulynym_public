/*
* Qulynym
* ScenesRouter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesRouterProtocol: class {
    func closeView() 
}

class ScenesRouter: ScenesRouterProtocol {
    // MARK:- Properties
    weak var controller: ScenesViewController!
    
    required init(_ view: ScenesViewController) {
        self.controller = view
    }
}

extension ScenesRouter {
    // MARK:- Protocol Methods
    func closeView() {
        controller.manager.visualEffectView.removeFromSuperview()
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
        AudioPlayer.scenesAudioPlayer.stop()
    }
}
