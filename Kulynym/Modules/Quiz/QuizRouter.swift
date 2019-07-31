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
    func close()
}

class QuizRouter: QuizRouterProtocol {
    weak var view: QuizViewController!
    
    required init(_ view: QuizViewController) {
        self.view = view
    }
}

extension QuizRouter {
    func close() {
        
    }
}
