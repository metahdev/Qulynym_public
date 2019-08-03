/*
* Kulynym
* ScenesRouter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesRouterProtocol: class {
    func presentItemVC(contentNames: [String], categoryName: String)
}

class ScenesRouter: ScenesRouterProtocol {
    // MARK:- Properties
    weak var controller: ScenesViewController!
    
    required init(_ view: ScenesViewController) {
        self.controller = view
    }
}

extension ScenesRouter {
    // MARK:- Protocol Methods
    func presentItemVC(contentNames: [String], categoryName: String) {
        let itemView = ItemViewController()
        controller.itemViewControllerDelegate = itemView
        controller.itemViewControllerDelegate.contentNames = contentNames
        controller.itemViewControllerDelegate.categoryName = categoryName
        itemView.transitioningDelegate = controller
        
        controller.show(itemView, sender: nil)
    }
}
