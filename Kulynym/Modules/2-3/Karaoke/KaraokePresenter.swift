/*
* Kulynym
* KaraokePresenter.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol KaraokePresenterProtocol: class {
    func closeView()
}

class KaraokePresenter: KaraokePresenterProtocol {
    // MARK:- Properties
    weak var view: KaraokeViewProtocol!
    var router: KaraokeRouterProtocol!
    
    required init(view: KaraokeViewProtocol) {
        self.view = view
    }
}

extension KaraokePresenter {
    // MARK:- Protocol Methods
    func closeView() {
        router.close() 
    }
}
