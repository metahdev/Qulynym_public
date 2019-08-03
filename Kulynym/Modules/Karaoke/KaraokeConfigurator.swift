/*
* Kulynym
* KaraokeConfigurator.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol KaraokeConfiguratorProtocol: class {
    func configure(with controller: KaraokeViewController)
}

class KaraokeConfigurator: KaraokeConfiguratorProtocol {
    func configure(with controller: KaraokeViewController) {
        let presenter = KaraokePresenter(controller)
        let interactor = KaraokeInteractor(presenter)
        let router = KaraokeRouter(view: controller)
        
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
