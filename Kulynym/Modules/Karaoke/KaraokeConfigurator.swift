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
    func configure(with view: KaraokeViewController)
}

class KaraokeConfigurator: KaraokeConfiguratorProtocol {
    func configure(with view: KaraokeViewController) {
        let router = KaraokeRouter(view: view)
        
        view.router = router
        router.view = view
    }
}
