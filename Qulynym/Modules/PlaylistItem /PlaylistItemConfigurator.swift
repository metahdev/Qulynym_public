/*
* Kulynym
* KaraokeConfigurator.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol PLaylistItemConfiguratorProtocol: class {
    func configure(with controller: PlaylistItemViewController)
}

class PlaylistItemConfigurator: PLaylistItemConfiguratorProtocol {
    func configure(with controller: PlaylistItemViewController) {
        let presenter = PlaylistItemPresenter(controller)
        let interactor = PlaylistItemInteractor(presenter)
        let router = PlaylistItemRouter(controller)
        
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
