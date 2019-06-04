/*
* Kulynym
* DrawingPresenter.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol DrawingPresenterProtocol: class {
    func closeView()
}

class DrawingPresenter: DrawingPresenterProtocol {
    // MARK:- Properties
    weak var view: DrawingViewProtocol!
    var interactor: DrawingInteractorProtocol!
    var router: DrawingRouterProtocol!
    
    required init(view: DrawingViewProtocol!) {
        self.view = view
    }
}

extension DrawingPresenter {
    func closeView() {
        router.close()
    }
}
