//
/*
* Kulynym
* SettingsPresenter.swift
*
* Created by: Баубек on 8/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol SettingsPresenterProtocol: class {
    func goToTextViewController()
    func closeView()
//    func goToInfoForParentsViewController()
//    func goToCreditsViewController()
    func setBackgroundMusicState()
}

class SettingsPresenter: SettingsPresenterProtocol {
    weak var controller: SettingsViewControllerProtocol!
    var interactor: SettingsInteractorProtocol!
    var router: SettingsRouterProtocol!
    
    required init(_ controller: SettingsViewControllerProtocol) {
        self.controller = controller
    }
}

extension SettingsPresenter {
    // MARK:- Protocol Methods
    func goToTextViewController() {
        let content = interactor.getContent(controller.isInfoForParents)
        router.showTextView(content)
    }
//
//    func goToInfoForParentsViewController() {
//        router.showInfoForParentsViewController()
//    }
//
//    func goToCreditsViewController() {
//        router.showCreditsViewController()
//    }
    
    func setBackgroundMusicState() {
        interactor.saveMusicState(controller.isChecked)
    }
    
    func closeView() {
        router.close()
    }
}
