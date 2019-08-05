/*
* Kulynym
* QuizRouter.swift
*
* Created by: Metah on 7/31/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol QuizRouterProtocol: class {
    func backToItem(didPass: Bool)
    func close()
}

class QuizRouter: QuizRouterProtocol {
    weak var controller: QuizViewController!
    
    required init(_ controller: QuizViewController) {
        self.controller = controller
    }
}

extension QuizRouter {
    func backToItem(didPass: Bool) {
        if !didPass {
            controller.itemView.slideCount -= 4
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func close() {
        if let firstViewController = controller.navigationController?.viewControllers[1] {
            controller.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
}
