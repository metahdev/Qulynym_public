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
    var view: PreschoolerViewProtocol! { set get }
    var interactor: PreschoolerInteractorProtocol! { set get }
    var router: PreschoolerRouterProtocol! { set get }
    
    func updateProgressState()
    func iconPressed(with index: Int)
    func closeView()
}

class PreschoolerPresenter: PreschoolerPresenterProtocol {
    // MARK:- Properties
    weak var view: PreschoolerViewProtocol!
    var interactor: PreschoolerInteractorProtocol!
    var router: PreschoolerRouterProtocol!
    
    required init(view: PreschoolerViewProtocol) {
        self.view = view
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
