/*
* Qulynym
* MenuConfigurator.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MenuConfiguratorProtocol: class {
    func configure(with controller: MenuViewController)
}

class MenuConfigurator: MenuConfiguratorProtocol {
    func configure(with controller: MenuViewController) {
        let presenter = MenuPresenter(controller)
        let router = MenuRouter(controller)
        
        controller.presenter = presenter
        presenter.router = router
    }
}
