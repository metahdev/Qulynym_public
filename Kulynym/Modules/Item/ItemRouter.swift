/*
 * Kulynym
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
    func openQuiz(_ cards: [String], with categoryName: String)
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
        controller.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func openQuiz(_ cards: [String], with categoryName: String) {
        let vc = QuizViewController()
        controller.quizViewController = vc
        controller.quizViewController.cards = cards
        controller.quizViewController.categoryName = categoryName
        vc.itemView = controller
        controller.present(vc, animated: true, completion: nil)
    }
}
