//
/*
* Kulynym
* QuizConfigurator.swift
*
* Created by: Metah on 7/31/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol QuizConfiguratorProtocol: class {
    func configure(with view: QuizViewController)
}

class QuizConfigurator: QuizConfiguratorProtocol {
    func configure(with view: QuizViewController) {
        let presenter = QuizPresenter(view)
        let interactor = QuizInteractor(presenter)
        let router = QuizRouter(view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

