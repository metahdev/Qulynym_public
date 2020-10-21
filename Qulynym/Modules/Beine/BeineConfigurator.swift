/*
* Qulynym
* BeineConfigurator.swift
*
* Created by: Metah on 10/22/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol BeineConfiguratorProtocol: class {
    func configure(with controller: BeineViewController)
}

class BeineConfigurator: BeineConfiguratorProtocol {
    func configure(with controller: BeineViewController) {
        let presenter = BeinePresenter(controller)
        let router = BeineRouter(controller)
        
        controller.presenter = presenter
        presenter.router = router
    }
}
