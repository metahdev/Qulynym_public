/*
* Qulynym
* QuizConfigurator.swift
*
* Created by: Metah on 7/31/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

final class QuizConfigurator {
    
    static func createModule(inputData: QuizModuleInputData, moduleOuput: QuizModuleOutput?) -> QuizViewController {
        let viewController = QuizViewController()
        let presenter = QuizPresenter(viewController)
        viewController.presenter = presenter
        
        let interactor = QuizInteractor(presenter)
        let router = QuizRouter(viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.moduleOuput = moduleOuput
        
        return viewController
    }
}

