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
    weak var view: StoryViewController!
    
    required init(_ view: StoryViewController) {
        self.view = view
    }
}

extension StoryRouter {
    func close() {
        view.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
