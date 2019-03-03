/*
* Kulynym
* MainMenuInteractor.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MainMenuInteractorProtocol: class {
    func updateProgressState()
}

class MainMenuInteractor: MainMenuInteractorProtocol {
    weak var presenter: MainMenuPresenterProtocol!
    
    required init(presenter: MainMenuPresenterProtocol) {
        self.presenter = presenter
    }
    
    func updateProgressState() {
        #warning ("Core Data Integration")
    }
}
