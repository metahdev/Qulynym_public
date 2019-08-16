/*
* Kulynym
* PlaylistConfigurator.swift
*
* Created by: Metah on 5/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol PlaylistConfiguratorProtocol: class {
    func configure(with controller: PlaylistViewController)
}

class PlaylistConfigurator: PlaylistConfiguratorProtocol {
    func configure(with controller: PlaylistViewController) {
        let presenter = PlaylistPresenter(controller)
        let interactor = PlaylistInteractor(presenter)
        let router = PlaylistRouter(controller)
        
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
