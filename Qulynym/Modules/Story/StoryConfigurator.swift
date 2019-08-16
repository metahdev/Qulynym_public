/*
* Kulynym
* StoryConfigurator.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol StoryConfiguratorProtocol: class {
    func configure(with controller: StoryViewController)
}

class StoryConfigurator: StoryConfiguratorProtocol {
    func configure(with controller: StoryViewController) {
        let presenter = StoryPresenter(controller)
        let interactor = StoryInteractor(presenter)
        let router = StoryRouter(controller)
        
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
