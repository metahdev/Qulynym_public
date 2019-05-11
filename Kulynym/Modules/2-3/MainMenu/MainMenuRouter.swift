/*
* Kulynym
* MainMenuRouter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MainMenuRouterProtocol: class {
    func goToScenes(with category: String)
}

class MainMenuRouter: MainMenuRouterProtocol {
    weak var view: MainMenuViewController!
    
    required init(view: MainMenuViewController) {
        self.view = view
    }
}

extension MainMenuRouter {
    // MARK:- Protocol Methods
    func goToScenes(with category: String) {
        let scenesView = ScenesViewController()
        view.scenesViewDelegate = scenesView
        view.scenesViewDelegate.category = category
        scenesView.transitioningDelegate = view
        
        view.present(scenesView, animated: true, completion: nil)
    }
}


