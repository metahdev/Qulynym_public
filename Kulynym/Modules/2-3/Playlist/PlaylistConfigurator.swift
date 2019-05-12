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
    func configure(with view: PlaylistViewController)
}

class PlaylistConfigurator: PlaylistConfiguratorProtocol {
    func configure(with view: PlaylistViewController) {
        let presenter = PlaylistPresenter(view: view)
        let interactor = PlaylistInteractor(presenter: presenter)
        let router = PlaylistRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
