/*
* Kulynym
* MainMenuPresenter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MainMenuPresenterProtocol: class {
    var view: MainMenuViewControllerProtocol! { set get }
    var interactor: MainMenuInteractorProtocol! { set get }
    var router: MainMenuRouterProtocol! { set get }
    
    func updateProgressState()
    func iconPressed(with category: String)
}

class MainMenuPresenter: MainMenuPresenterProtocol {
    // MARK:- Properties
    weak var view: MainMenuViewControllerProtocol!
    var interactor: MainMenuInteractorProtocol!
    var router: MainMenuRouterProtocol!
    
    required init(view: MainMenuViewControllerProtocol) {
        self.view = view
    }
}

extension MainMenuPresenter {
    // MARK:- Protocol Methods
    func updateProgressState() {
        interactor.updateProgressState()
    }
    
    func iconPressed(with category: String) {
        router.iconPressed(with: category)
    }
}
