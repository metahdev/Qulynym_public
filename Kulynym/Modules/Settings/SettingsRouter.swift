//
/*
* Kulynym
* SettingsRouter.swift
*
* Created by: Баубек on 8/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

protocol SettingsRouterProtocol: class {
    func showTextView(_ content: String)
//    func showInfoForParentsViewController()
//    func showCreditsViewController()
    func close()
}

class SettingsRouter: SettingsRouterProtocol {
    // MARK:- Properties
    weak var controller: SettingsViewController!
    
    required init(_ controller: SettingsViewController) {
        self.controller = controller
    }
}

extension SettingsRouter {
    // MARK:- Protocol Methods
    func showTextView(_ content: String) {
        controller.textViewController.content = content
        let vc = TextViewController()

        controller.textViewController = vc
        controller.show(vc, sender: nil)
    }
    
//    func showInfoForParentsViewController() {
//        controller.show(InfoForParentsViewController(), sender: nil)
//    }
//
//    func showCreditsViewController() {
//        controller.show(CreditsViewController(), sender: nil)
//    }
//
    func close() {
        controller.navigationController!.popViewController(animated: true)
    }
}
