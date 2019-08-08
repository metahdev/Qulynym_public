//
/*
* Kulynym
* KaraokePresenter.swift
*
* Created by: Metah on 8/4/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol KaraokePresenterProtocol: class {
    func getMaxCount()
    func backToPreviousVideo()
    func nextVideo() 
    func close()
}

class KaraokePresenter: KaraokePresenterProtocol {
    weak var controller: KaraokeViewControllerProtocol!
    var interactor: KaraokeInteractorProtocol!
    var router: KaraokeRouterProtocol!
    
    required init(_ controller: KaraokeViewControllerProtocol) {
        self.controller = controller
    }
}

extension KaraokePresenter {
    // MARK:- Protocol Methods
    func getMaxCount() {
        controller.maxIndex = interactor.getMaxCount()
    }
    
    func backToPreviousVideo() {
        controller.content = interactor.getPreviousVideo(&controller.index)
        controller.setViewsProperties()
        controller.playVideo()
    }
    
    func nextVideo() {
        controller.content = interactor.getNextVideo(&controller.index)
        controller.setViewsProperties()
        controller.playVideo()
    }
    
    func close() {
        router.close()
    }
}
