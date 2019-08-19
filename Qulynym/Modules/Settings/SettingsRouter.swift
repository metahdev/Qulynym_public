/*
 * Kulynym
 * SettingsRouter.swift
 *
 * Created by: Baubek on 8/5/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

protocol SettingsRouterProtocol: class {
    func showTextView(_ content: NSAttributedString, title: String)
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
    func showTextView(_ content: NSAttributedString, title: String) {
        let vc = TextViewController()
        controller.textViewController = vc
        
        controller.textViewController.content = content
        controller.textViewController.titleText = title
        
        controller.show(vc, sender: nil)
    }
    
    func close() {
        controller.navigationController!.popViewController(animated: true)
    }
}
