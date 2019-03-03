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
    var category: String { get set }
    func getScenes()
    func playAudio()
    func startTimer()
    func skipBtnPressed()
}

class ScenesPresenter: ScenesPresenterProtocol {
    weak var view: ScenesViewControllerProtocol!
    var interactor: ScenesInteractorProtocol!
    var router: ScenesRouterProtocol!
    
    var category = ""
    var currentSlide = 0
    var scenesNames = [String]()
    var seconds = 0.0
    var timer = Timer()
    
    required init(view: ScenesViewControllerProtocol) {
        self.view = view
    }
}

extension ScenesPresenter {
    func getScenes() {
        scenesNames = interactor.getScenes(of: category)
        view.fillContent(image: scenesNames[currentSlide])
        currentSlide += 1
    }
    
    func playAudio() {
        AudioPlayer.backgroundAudioPlayer.stop()
        AudioPlayer.initExtraAudioPath(with: category, audioPlayer: .scenes)
        AudioPlayer.playScenesAudio()
    }
    
    func startTimer() {
        seconds = AudioPlayer.scenesAudioPlayer.duration
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkState), userInfo: nil, repeats: true)
    }
    
    @objc func checkState() {
        seconds -= 1
        
        switch Int(seconds) {
        case 10, 20:
            view.fillContent(image: scenesNames[currentSlide])
            currentSlide += 1
        default:
            break
        }
        
        if Int(seconds) == 0 {
            timer.invalidate()
            router.showNextVC(category: category)
        }
    }
    
    func skipBtnPressed() {
        timer.invalidate()
        AudioPlayer.scenesAudioPlayer.stop()
        router.showNextVC(category: category)
    }
}
