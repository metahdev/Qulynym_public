/*
 * Kulynym
 * File.swift
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
        let presenter = ItemPresenter(view: viewController)
        let interactor = ItemInteractor(presenter: presenter)
        let router = ItemRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
