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
}

class ItemRouter {
    // MARK:- Properties
    weak var view: ItemViewController!
    
    required init(view: ItemViewController) {
        self.view = view
    }
}

extension ItemRouter: ItemRouterProtocol {
    // MARK:- Protocol Methods
    func closeView() {
        view.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
