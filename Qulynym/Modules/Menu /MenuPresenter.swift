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
    func fetchData()
    func dataReady() 
    func didSelectMenuCell(at index: Int)
    func didSelectPlaylistCell(at index: Int)
    func didSelectVideoCell(at index: Int)
    func didSelectToddlerCell(at index: Int)
    func didSelectGamesCell(at index: Int)
    func closeView()
    func goToSettings()
}

class MenuPresenter: MenuPresenterProtocol {
    // MARK:- Properties
    weak var controller: MenuViewControllerProtocol!
    var interactor: MenuInteractor!
    var router: MenuRouterProtocol!
    
    required init(_ controller: MenuViewControllerProtocol) {
        self.controller = controller
    }
}

extension MenuPresenter {
    // MARK:- Protocol Methods
    func fetchData() {
        if controller.menuType == .beineler {
            interactor.fetchIDs[1] = controller.playlistID
        }
        interactor.fetchBeine()
    }
    
    func dataReady() {
        controller.beineler = interactor.beineler
        controller.reloadData()
    }
    
    func didSelectMenuCell(at index: Int) {
        switch index {
        case 0: router.showBeinelerPlaylists()
        case 1: router.showToddlerEdu()
        case 4: router.showDrawingView()
        case 5: router.showGamesMenu()
        default: router.showPlaylist(isKaraoke: (index == 2))
        }
    }
    
    func didSelectPlaylistCell(at index: Int) {
        router.showBeineler(playlist: controller.beineler[index].id)
    }
    
    func didSelectVideoCell(at index: Int) {
        router.showVideoView(video: controller.beineler[index].id)
    }
    
    func didSelectToddlerCell(at index: Int) {
        router.showItemView(content: ContentService.toddlerSections[index])
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
