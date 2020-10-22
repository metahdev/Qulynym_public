/*
 * Qulynym
 * ItemRouter.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

protocol ItemRouterProtocol: class {
    func closeView()
    func openQuiz(quizModuleOutput: QuizModuleOutput?, _ cards: [String], with categoryName: String, and count: Int)
}

class ItemRouter {
    // MARK:- Properties
    weak var controller: ItemViewController!
    
    required init(_ controller: ItemViewController) {
        self.controller = controller
    }
}

extension ItemRouter: ItemRouterProtocol {
    
    // MARK:- Protocol Methods
    func closeView() {
        if let firstViewController = controller.navigationController?.viewControllers[1] {
            controller.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
    
    func openQuiz(quizModuleOutput: QuizModuleOutput?, _ cards: [String], with categoryName: String, and count: Int) {
        let viewController = QuizConfigurator.createModule(
            inputData: QuizModuleInputData(
                cards: cards,
                categoryName: categoryName,
                count: count,
                areImagesTransparent: controller.areImagesTransparent
            ),
            moduleOuput: quizModuleOutput
        )
//        vc.itemView = controller
        controller.show(viewController, sender: nil)
    }
}
