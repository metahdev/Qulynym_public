/*
 * Kulynym
 * File.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

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
        view.dismiss(animated: true, completion: nil)
    }
}
