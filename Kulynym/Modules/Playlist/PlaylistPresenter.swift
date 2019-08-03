/*
* Kulynym
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
    weak var view: PlaylistViewControllerProtocol!
    var interactor: PlaylistInteractorProtocol!
    var router: PlaylistRouterProtocol!
    
    required init(view: PlaylistViewControllerProtocol) {
        self.view = view
    }
}

extension PlaylistPresenter {
    // MARK:- Protocol Methods
    func getContent() {
        view.content = interactor.getContent(view.isKaraoke)
    }
    
    func closeView() {
        router.close()
    }
    
    func openItem(at index: Int) {
        router.presentContent(index)
    }
}
