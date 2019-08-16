/*
 * Kulynym
 * ItemConfigurator.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ItemConfiguratorProtocol: class {
    func configure(with viewController: ItemViewController)
}

class ItemConfigurator: ItemConfiguratorProtocol {
    func configure(with viewController: ItemViewController) {
        let presenter = ItemPresenter(viewController)
        let interactor = ItemInteractor(presenter)
        let router = ItemRouter(viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
