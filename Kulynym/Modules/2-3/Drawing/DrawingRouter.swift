/*
* Kulynym
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
    weak var view: DrawingViewController!
    
    required init(_ view: DrawingViewController) {
        self.view = view
    }
}

extension DrawingRouter {
    func close() {
        view.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
