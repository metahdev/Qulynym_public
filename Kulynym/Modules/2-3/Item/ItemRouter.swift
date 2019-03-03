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
    weak var view: ItemViewController!
    
    required init(view: ItemViewController) {
        self.view = view
    }
}

extension ItemRouter: ItemRouterProtocol {
    func closeView() {
        let navController = view.navigationController
        navController?.popToRootViewController(animated: true)
    }
}
