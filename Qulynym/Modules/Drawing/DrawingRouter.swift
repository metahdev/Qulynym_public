 /*
* Qulynym
* DrawingRouter.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
 */

import Foundation

protocol DrawingRouterProtocol: class {
    func close()
}

class DrawingRouter: DrawingRouterProtocol {
    // MARK:- Properties
    weak var controller: DrawingViewController!
    
    required init(_ controller: DrawingViewController) {
        self.controller = controller
    }
}

extension DrawingRouter {
    func close() {
        controller.navigationController?.popViewController(animated: true)
    }
}
