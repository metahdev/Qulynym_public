/*
* Kulynym
* MenuRouter.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MenuRouterProtocol: class {
    func showToddlerEdu()
    func showPlaylist(isKaraoke: Bool)
    func showDrawingView()
    func showPreschoolerEdu()
    func showScenesView(content section: EduSection)
    func showGamesMenu()
    func openFlappyBird()
    func close()
}

class MenuRouter: MenuRouterProtocol {
    // MARK:- Properties
    weak var view: MenuViewController!
    
    required init(_ view: MenuViewController) {
        self.view = view 
    }
}

extension MenuRouter {
    // MARK:- Protocol Methods
    func showToddlerEdu() {
        let vc = MenuViewController()
        view.secondMenuViewDelegate = vc
        view.secondMenuViewDelegate.menuType = .toddler
        presentAnotherView(view: vc)
    }
    
    func showPlaylist(isKaraoke: Bool) {
        let vc = PlaylistViewController()
        view.playlistViewDelegate = vc
        view.playlistViewDelegate.isKaraoke = isKaraoke
        presentAnotherView(view: vc)
    }
    
    func showDrawingView() {
        presentAnotherView(view: DrawingViewController())
    }
    
    func showPreschoolerEdu() {
        presentAnotherView(view: PreschoolerViewController())
    }
    
    func showScenesView(content section: EduSection) {
        let vc = ScenesViewController()
        view.scenesViewDelegate = vc
        view.scenesViewDelegate.section = section
        presentAnotherView(view: vc)
    }
    
    func showGamesMenu() {
        let vc = MenuViewController()
        view.secondMenuViewDelegate = vc
        view.secondMenuViewDelegate.menuType = .games
        presentAnotherView(view: vc)
    }
    
    func openFlappyBird() {
        
    }
    
    func close() {
        view.dismiss(animated: true, completion: nil)
    }
    
    private func presentAnotherView(view toPresent: UIViewController) {
        toPresent.transitioningDelegate = view
        view.present(toPresent, animated: true, completion: nil)
    }
}
