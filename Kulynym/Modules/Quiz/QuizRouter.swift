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
    weak var view: QuizViewController!
    
    required init(_ view: QuizViewController) {
        self.view = view
    }
}

extension QuizRouter {
    func backToItem(didPass: Bool) {
        if !didPass {
            view.itemView.slideCount -= 4
        }
        view.dismiss(animated: true, completion: nil)
    }
    
    func close() {
        if let firstViewController = controller.navigationController?.viewControllers[1] {
            controller.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
}
