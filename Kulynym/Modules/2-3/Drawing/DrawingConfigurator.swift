//
/*
* Kulynym
* DrawingConfigurator.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol DrawingConfiguratorProtocol: class {
    func configure(with view: DrawingViewController)
}

class DrawingConfigurator: DrawingConfiguratorProtocol {
    func configure(with view: DrawingViewController) {
        let presenter = DrawingPresenter(view: view)
        let interactor = DrawingInteractor(presenter)
        let router = DrawingRouter(view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
