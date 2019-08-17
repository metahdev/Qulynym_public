/*
* Qulynym
* ScenesConfigurator.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesConfiguratorProtocol: class {
    func configure(with viewController: ScenesViewController)
}

class ScenesConfigurator: ScenesConfiguratorProtocol {
    func configure(with viewController: ScenesViewController) {
        let presenter = ScenesPresenter(viewController)
        let interactor = ScenesInteractor(presenter)
        let router = ScenesRouter(viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
