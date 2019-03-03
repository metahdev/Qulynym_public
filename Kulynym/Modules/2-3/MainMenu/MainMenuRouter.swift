/*
* Kulynym
* MainMenuRouter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MainMenuRouterProtocol: class {
    func iconPressed(with category: String)
}

class MainMenuRouter: MainMenuRouterProtocol {
    weak var view: MainMenuViewController!
    
    required init(view: MainMenuViewController) {
        self.view = view
    }
    
    func iconPressed(with category: String) {
        let scenesViewController = ScenesViewController(category: category)
        view.show(scenesViewController, sender: nil)
    }
}
