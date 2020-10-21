/*
* Qulynym
* BeineInteractor.swift
*
* Created by: Metah on 10/22/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol BeineInteractorProtocol: class {
}

class BeineInteractor: BeineInteractorProtocol {
    weak var presenter: BeinePresenterProtocol!
    
    required init(_ presenter: BeinePresenterProtocol) {
        self.presenter = presenter
    }
}

extension BeineInteractor {
    
}
