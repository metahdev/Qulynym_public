/*
* Kulynym
* MainMenuPresenter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol PreschoolerPresenterProtocol: class {    
    func updateProgressState()
    func iconPressed(with index: Int)
    func closeView()
}

class PreschoolerPresenter: PreschoolerPresenterProtocol {
    // MARK:- Properties
    weak var controller: PreschoolerViewControllerProtocol!
    var interactor: PreschoolerInteractorProtocol!
    var router: PreschoolerRouterProtocol!
    
    required init(_ controller: PreschoolerViewControllerProtocol) {
        self.controller = controller
    }
}

extension PreschoolerPresenter {
    // MARK:- Protocol Methods
    func updateProgressState() {
        interactor.updateProgressState()
    }
    
    func iconPressed(with index: Int) {
    }
    
    func closeView() {
        router.close()
    }
}
