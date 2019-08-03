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
    func close()
}

class PreschoolerRouter: PreschoolerRouterProtocol {
    // MARK:- Properties
    weak var controller: PreschoolerViewController!
    
    required init(_ controller: PreschoolerViewController) {
        self.controller = controller
    }
}

extension PreschoolerRouter {
    func close() {
        controller.navigationController?.popViewController(animated: true)
    }
}


