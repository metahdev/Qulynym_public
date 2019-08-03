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
    func close() {
        router.close()
    }
}
