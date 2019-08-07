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
    weak var controller: ScenesViewControllerProtocol!
    var interactor: ScenesInteractorProtocol!
    var router: ScenesRouterProtocol!
    
    var scenesNames = [String]()
    var timerManager: TimerController!
    var timepoints = [Int]()
    
    required init(_ view: ScenesViewControllerProtocol) {
        self.controller = view
    }
}

extension ScenesPresenter {
    // MARK:- Protocol Methods
    func getScenes() {
        interactor.section = controller.section
        scenesNames = interactor.getScenes()
        timepoints = interactor.getTimepoints()
        controller.fillContent(image: scenesNames[0])
    }
    
    func playAudio() {
        AudioPlayer.setupExtraAudio(with: controller.section.name, audioPlayer: .scenes)
    }
    
    func startTimer() {
        timerManager = TimerController()
        timerManager.delegate = self
        
        self.timerManager.startTimer()
    }
    
    func skipBtnPressed() {
        timerManager.timer.invalidate()
        AudioPlayer.scenesAudioPlayer.stop()
        AudioPlayer.setupExtraAudio(with: "swish", audioPlayer: .effects)
        configureDirection()
    }
    
    private func configureDirection() {
        router.presentItemVC(contentNames: controller.section.contentNames, categoryName: controller.section.name)
    }
}

extension ScenesPresenter: TimerControllerDelegate {
    // MARK:- Delegate Methods
    func notifyOfTimepoints() {
        controller.fillContent(image: scenesNames[timerManager.currentSlide])
    }
    
    func notifyTimerEnded() {
        configureDirection()
    }
}
