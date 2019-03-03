/*
* Kulynym
* MainMenuConfigurator.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MainMenuConfiguratorProtocol: class {
    func configure(with viewController: MainMenuViewController)
}

class MainMenuConfigurator: MainMenuConfiguratorProtocol {
    func configure(with viewController: MainMenuViewController) {
        let presenter = MainMenuPresenter(view: viewController)
        let interactor = MainMenuInteractor(presenter: presenter)
        let router = MainMenuRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
