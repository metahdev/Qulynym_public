/*
* Qulynym
* BeineRouter.swift
*
* Created by: Metah on 10/22/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

protocol BeineRouterProtocol: class {
    
}

class BeineRouter: BeineRouterProtocol {
    // MARK:- Properties
    weak var controller: BeineViewController!
    
    required init(_ controller: BeineViewController) {
        self.controller = controller
    }
}

extension BeineRouter {
    
}
