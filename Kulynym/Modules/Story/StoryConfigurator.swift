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
    func configure(with view: StoryViewController)
}

class StoryConfigurator: StoryConfiguratorProtocol {
    func configure(with view: StoryViewController) {
        let presenter = StoryPresenter(view)
        let interactor = StoryInteractor(presenter)
        let router = StoryRouter(view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
