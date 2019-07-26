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
    func closeView()
}

class MenuPresenter: MenuPresenterProtocol {
    // MARK:- Properties
    weak var view: MenuViewProtocol!
    var interactor: MenuInteractor!
    var router: MenuRouterProtocol!
    
    required init(_ view: MenuViewProtocol) {
        self.view = view
    }
}

extension MenuPresenter {
    // MARK:- Protocol Methods
    func getSections() {
        view.sections = interactor.getSections(view.isToddler)
    }
    
    func didSelectMenuCell(at index: Int) {
        switch index {
        case 0: router.showToddlerEdu()
        case 3: router.showDrawingView()
        case 4: router.showPreschoolerEdu()
        default: router.showPlaylist(isKaraoke: (index == 1))
        }
    }
    
    func didSelectToddlerCell(at index: Int) {
        let section = view.sections[index]
        router.showScenesView(content: section as! EduSection)
    }
    
    func closeView() {
        router.close()
    }
}
