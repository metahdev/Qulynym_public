/*
* Kulynym
* ScenesRouter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesRouterProtocol: class {
    func showNextVC(category: String)
}

class ScenesRouter: ScenesRouterProtocol {
    weak var view: ScenesViewController!
    
    required init(view: ScenesViewController) {
        self.view = view
    }
    
    func showNextVC(category: String) {
        let vc = ItemViewController(category: category)
        view.show(vc, sender: nil)
    }
}
