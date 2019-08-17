/*
* Qulynym
* ScenesInteractor.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesInteractorProtocol: class {
}

class ScenesInteractor: ScenesInteractorProtocol {
    // MARK:- Properties
    weak var presenter: ScenesPresenterProtocol!
    
    required init(_ presenter: ScenesPresenterProtocol) {
        self.presenter = presenter
    }
}

extension ScenesInteractor {
    
}
