/*
* Kulynym
* MainMenuInteractor.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import CoreData

protocol MainMenuInteractorProtocol: class {
    func updateProgressState()
}

class MainMenuInteractor: MainMenuInteractorProtocol {
    // MARK:- Properties
    weak var presenter: MainMenuPresenterProtocol!
    
    required init(presenter: MainMenuPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MainMenuInteractor {
    // MARK:- Protocol Methods
    func updateProgressState() {
        
    }
}
