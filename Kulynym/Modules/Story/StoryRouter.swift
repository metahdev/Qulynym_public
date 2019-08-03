/*
* Kulynym
* StoryRouter.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol StoryRouterProtocol: class {
    func close() 
}

class StoryRouter: StoryRouterProtocol {
    // MARK:- Properites
    weak var controller: StoryViewController!
    
    required init(_ controller: StoryViewController) {
        self.controller = controller
    }
}

extension StoryRouter {
    func close() {
        controller.navigationController?.popViewController(animated: true)
    }
}
