/*
* Kulynym
* MenuConfigurator.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MenuConfiguratorProtocol: class {
    func configure(with view: MenuViewController)
}

class MenuConfigurator: MenuConfiguratorProtocol {
    func configure(with view: MenuViewController) {
        let presenter = MenuPresenter(view)
        let interactor = MenuInteractor(presenter)
        let router = MenuRouter(view)
        
        view.presenter = presenter
        presenter.interactor = interactor 
        presenter.router = router
    }
}
