/*
* Qulynym
* MenuPresenter.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MenuPresenterProtocol: class {
    func didSelectMenuCell(at index: Int)
    func didSelectPlaylistCell(playlist id: String)
    func didSelectVideoCell(index: Int)
    func didSelectToddlerCell(at index: Int)
    func didSelectGamesCell(at index: Int)
    func closeView()
    func goToSettings()
}

class MenuPresenter: MenuPresenterProtocol {
    // MARK:- Properties
    weak var controller: MenuViewControllerProtocol!
    var router: MenuRouterProtocol!
    
    required init(_ controller: MenuViewControllerProtocol) {
        self.controller = controller
    }
}

extension MenuPresenter {
    // MARK:- Protocol Methods
    func didSelectMenuCell(at index: Int) {
        switch index {
        case 0: router.showBeinelerPlaylists()
        case 1: router.showToddlerEdu()
        case 4: router.showDrawingView()
        case 5: router.showGamesMenu()
        default: router.showPlaylist(isKaraoke: (index == 2))
        }
    }
    
    func didSelectPlaylistCell(playlist id: String) {
        router.showBeineler(playlist: id)
    }
    
    func didSelectVideoCell(index: Int) {
        router.showVideoView(index: index, beineler: controller.dataFetchAPI.beineler, token: controller.dataFetchAPI.token, playlistID: controller.playlistID)
    }
    
    func didSelectToddlerCell(at index: Int) {
        router.showItemView(content: Content.toddlerSections[index])
    }
    
    func didSelectGamesCell(at index: Int) {
        switch index {
        case 0:
            router.openFlappyBird()
        default:
            return
        }
    }
    
    func closeView() {
        router.close()
    }
    
    func goToSettings() {
        router.showSettings()
    }
}
