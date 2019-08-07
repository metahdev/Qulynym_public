//
/*
* Kulynym
* SettingsConfigurator.swift
*
* Created by: Баубек on 8/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol SettingsConfiguratorProtocol: class {
    func configure(with controller: SettingsViewController)
}

class SettingsConfigurator: SettingsConfiguratorProtocol {
    func configure(with controller: SettingsViewController) {
        let presenter = SettingsPresenter(controller)
        let interactor = SettingsInteractor(presenter)
        let router = SettingsRouter(controller)
        
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
