/*
 * Qulynym
 * PlaylistPresenter.swift
 *
 * Created by: Metah on 5/12/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol PlaylistPresenterProtocol: class {
    func getContent()
    func closeView()
    func openItem(at: Int)
}

class PlaylistPresenter: PlaylistPresenterProtocol {
    // MARK:- Properties
    weak var controller: PlaylistViewControllerProtocol!
    var interactor: PlaylistInteractorProtocol!
    var router: PlaylistRouterProtocol!
    
    required init(_ controller: PlaylistViewControllerProtocol) {
        self.controller = controller
    }
}

extension PlaylistPresenter {
    // MARK:- Protocol Methods
    func getContent() {
        controller.content = interactor.getContent(controller.isKaraoke)
    }
    
    func closeView() {
        router.close()
    }
    
    func openItem(at index: Int) {
        router.presentContent(index)
    }
}
