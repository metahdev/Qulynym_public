/*
* Kulynym
* StoryPresenter.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol StoryPresenterProtocol: class {
    func closeView()
}

class StoryPresenter: StoryPresenterProtocol {
    // MARK:- Properties
    weak var view: StoryViewProtocol!
    var router: StoryRouterProtocol!
    var interactor: StoryInteractorProtocol!
    var timer: TimerController!
    var timepoints = [10, ]
    
    required init(_ view: StoryViewProtocol) {
        self.view = view
    }
}

extension StoryPresenter {
    // MARK:- Protocol Methods
    func closeView() {
        router.close()
    }
}

