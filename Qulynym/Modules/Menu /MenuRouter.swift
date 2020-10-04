/*
* Qulynym
* MenuRouter.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MenuRouterProtocol: class {
    func showBeinelerPlaylists()
    func showBeineler(playlist id: String)
    func showVideoView(index: Int, beineler: [Beine], token: String?, playlistID: String?)
    func showToddlerEdu()
    func showPlaylist(isKaraoke: Bool)
    func showDrawingView()
    func showItemView(content section: EduSection)
    func showGamesMenu()
    func openFlappyBird()
    func close()
    func showSettings()
}

class MenuRouter: MenuRouterProtocol {
    // MARK:- Properties
    weak var controller: MenuViewController!
    
    required init(_ controller: MenuViewController) {
        self.controller = controller
    }
}

extension MenuRouter {
    // MARK:- Protocol Methods
    func showBeinelerPlaylists() {
        reuseMenu(menuType: .beinelerPlaylists, id: nil)
    }
    
    func showBeineler(playlist id: String) {
        reuseMenu(menuType: .beineler, id: id)
    }
    
    func showVideoView(index: Int, beineler: [Beine], token: String?, playlistID: String?) {
        let vc = BeineViewController()
        controller.beineViewDelegate = vc
        controller.beineViewDelegate.index = index
        controller.beineViewDelegate.beineler = beineler
        controller.beineViewDelegate.token = token
        controller.beineViewDelegate.playlistID = playlistID
        showAnotherView(view: vc)
    }
    
    func showToddlerEdu() {
        reuseMenu(menuType: .toddler, id: nil)
    }
    
    func showPlaylist(isKaraoke: Bool) {
        let vc = PlaylistViewController()
        controller.playlistViewDelegate = vc
        controller.playlistViewDelegate.isKaraoke = isKaraoke
        showAnotherView(view: vc)
    }
    
    func showDrawingView() {
        showAnotherView(view: DrawingViewController())
    }
   
    func showItemView(content section: EduSection) {
        let vc = ItemViewController()
        controller.itemViewDelegate = vc
        controller.itemViewDelegate.section = section
        showAnotherView(view: vc)
    }
    
    func showGamesMenu() {
        reuseMenu(menuType: .games, id: nil)
    }
    
    func openFlappyBird() {
        controller.hideTransitionViews(true)
        AppUtility.currentOrientation = UIApplication.shared.statusBarOrientation
        
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.controller.hideBackground(true)
        })
        
        self.showAnotherView(view: GameViewController())
    }
    
    func close() {
        controller.navigationController!.popViewController(animated: true)
    }
    
    func showSettings() {
        showAnotherView(view: SettingsViewController())
    }
    
    private func reuseMenu(menuType: Menu, id: String?) {
        let vc = MenuViewController()
        controller.secondMenuViewDelegate = vc
        controller.secondMenuViewDelegate.menuType = menuType
        if let id = id {
            controller.secondMenuViewDelegate.playlistID = id
        }
        showAnotherView(view: vc)
    }
    
    private func showAnotherView(view toPresent: UIViewController) {
        controller.show(toPresent, sender: nil)
    }
}
