/*
* Kulynym
* MenuPresenter.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MenuPresenterProtocol: class {
    func getSections()
    func didSelectMenuCell(at index: Int)
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
    func getSections() {
        if controller.menuType == .toddler {
            controller.eduSections = interactor.getEduSections()
        } else {
            controller.sections = interactor.getStringSections(controller.menuType)
        }
    }
    
    func didSelectMenuCell(at index: Int) {
        switch index {
        case 0: router.showToddlerEdu()
        case 3: router.showDrawingView()
        case 4: router.showPreschoolerEdu()
        case 5: router.showGamesMenu() 
        default: router.showPlaylist(isKaraoke: (index == 1))
        }
    }
    
    func didSelectToddlerCell(at index: Int) {
        router.showScenesView(content: controller.eduSections[index])
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
        callQuitAudioEffect()
        router.close()
    }
    
    func goToSettings() {
        router.showSettings()
    }
}
