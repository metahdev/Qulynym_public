/*
* Kulynym
* ScenesPresenter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesPresenterProtocol: class {    
    func getScenes()
    func playAudio()
    func startTimer()
    func skipBtnPressed()
}

class ScenesPresenter: ScenesPresenterProtocol {
    // MARK:- Properties
    weak var view: ScenesViewControllerProtocol!
    var interactor: ScenesInteractorProtocol!
    var router: ScenesRouterProtocol!
    
    var scenesNames = [String]()
    var timerManager: TimerController!
    var timepoints = [Int]()
    
    required init(view: ScenesViewControllerProtocol) {
        self.view = view
    }
}

extension ScenesPresenter {
    // MARK:- Protocol Methods
    func getScenes() {
        interactor.category = view.category
        scenesNames = interactor.getScenes()
        timepoints = interactor.getTimepoints()
        view.fillContent(image: scenesNames[0])
    }
    
    func playAudio() {
        AudioPlayer.setupExtraAudio(with: view.category, audioPlayer: .scenes)
    }
    
    func startTimer() {
        timerManager = TimerController()
        timerManager.delegate = self
        
        self.timerManager.startTimer()
    }
    
    func skipBtnPressed() {
        timerManager.timer.invalidate()
        AudioPlayer.scenesAudioPlayer.stop()
        router.showNextVC(category: view.category)
    }
}

extension ScenesPresenter: TimerManagerDelegate {
    // MARK:- Delegate Methods
    func notifyOfTimepoints() {
        view.fillContent(image: scenesNames[timerManager.currentSlide])
    }
    
    func notifyTimerEnded() {
        router.showNextVC(category: view.category)
    }
}
