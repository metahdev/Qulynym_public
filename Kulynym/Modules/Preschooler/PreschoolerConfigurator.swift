/*
* Kulynym
* PreschoolerConfigurator.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol PreschoolerConfiguratorProtocol: class {
    func configure(with viewController: PreschoolerViewController)
}

class PreschoolerConfigurator: PreschoolerConfiguratorProtocol {
    func configure(with viewController: PreschoolerViewController) {
        let presenter = PreschoolerPresenter(view: viewController)
        let interactor = PreschoolerInteractor(presenter: presenter)
        let router = PreschoolerRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
