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
    func startTimer()
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
    func startTimer() {
        timer = TimerController()
        timer.delegate = self
        
        self.timer.startTimer()
    }
    
    func closeView() {
        router.close()
    }
}

extension StoryPresenter: TimerControllerDelegate {
    // MARK:- Protocol Methods
    func notifyOfTimepoints() {
        view.curtainsAnimation()
        switch timer.seconds {
            #warning("refactor")
        case 10:
            view.curtainsAnimation()
            view.fillContent(firstChar: "kolobokChar", secondChar: "rabbit", background: "kolobokForest")
            view.charactersAnimation(char: .second, duration: 5)
        case 15:
            view.charactersAnimation(char: .first, duration: 10)
        case 25:
            view.curtainsAnimation()
            view.fillContent(firstChar: "kolobokChar", secondChar: "kolobokWolf", background: "kolobokForest")
            view.charactersAnimation(char: .second, duration: 5)
        case 30:
            view.curtainsAnimation()
            view.fillContent(firstChar: "kolobokChar", secondChar: "kolobokBear", background: "kolobokForest")
            view.charactersAnimation(char: .first, duration: 10)
        default: break
        }
    }
    
    func notifyTimerEnded() {
        #warning("Alert")
    }
}
