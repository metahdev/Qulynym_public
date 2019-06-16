/*
* Kulynym
* MainMenuRouter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol PreschoolerRouterProtocol: class {
}

class PreschoolerRouter: PreschoolerRouterProtocol {
    // MARK:- Properties
    weak var view: PreschoolerViewController!
    
    required init(view: PreschoolerViewController) {
        self.view = view
    }
}

extension PreschoolerRouter {
}


