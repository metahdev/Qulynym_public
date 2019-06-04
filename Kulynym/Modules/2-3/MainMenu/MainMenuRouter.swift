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
    func goToScenes(to section: Section)
}

class MainMenuRouter: MainMenuRouterProtocol {
    // MARK:- Properties
    weak var view: MainMenuViewController!
    
    required init(view: MainMenuViewController) {
        self.view = view
    }
}

extension MainMenuRouter {
    // MARK:- Protocol Methods
    func goToScenes(to section: Section) {
        let scenesView = ScenesViewController()
        view.scenesViewDelegate = scenesView
        scenesView.section = section
        scenesView.transitioningDelegate = view
        
        view.present(scenesView, animated: true, completion: nil)
    }
}


