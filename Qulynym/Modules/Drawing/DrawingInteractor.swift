 /*
* Qulynym
* DrawingInteractor.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
 */

import Foundation

protocol DrawingInteractorProtocol: class {
}

class DrawingInteractor: DrawingInteractorProtocol {
    // MARK:- Properties
    weak var presenter: DrawingPresenterProtocol!
    
    required init(_ presenter: DrawingPresenterProtocol) {
        self.presenter = presenter
    }
}

