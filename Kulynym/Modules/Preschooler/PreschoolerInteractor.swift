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

protocol PreschoolerInteractorProtocol: class {
    func updateProgressState()
}

class PreschoolerInteractor: PreschoolerInteractorProtocol {
    // MARK:- Properties
    weak var presenter: PreschoolerPresenterProtocol!
    
    required init(presenter: PreschoolerPresenterProtocol) {
        self.presenter = presenter
    }
}

extension PreschoolerInteractor {
    // MARK:- Protocol Methods
    func updateProgressState() {
        
    }
}
