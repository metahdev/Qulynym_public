/*
* Qulynym
* BeinePresenter.swift
*
* Created by: Metah on 10/22/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol BeinePresenterProtocol: class {
    
}

class BeinePresenter: BeinePresenterProtocol {
    // MARK:- Properties
    weak var controller: BeineViewControllerProtocol!
    var router: BeineRouterProtocol!
    
    required init(_ controller: BeineViewControllerProtocol) {
        self.controller = controller
    }
}

extension BeinePresenter {
    
}
