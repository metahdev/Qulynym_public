/*
 * Qulynym
 * QuizRouter.swift
 *
 * Created by: Metah on 7/31/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol QuizRouterProtocol: class {
    func backToItem(didPass: Bool)
    func returnToMenu()
    func close()
}

class QuizRouter: QuizRouterProtocol {
    weak var controller: QuizViewController!
    
    required init(_ controller: QuizViewController) {
        self.controller = controller
    }
}

extension QuizRouter {
    func backToItem(didPass: Bool) {
        if !didPass {
            AudioPlayer.setupExtraAudio(with: "tryAgain", audioPlayer: .effects)
            controller.itemView.slideCount -= 4
        }
        controller.itemView.returnedFromQuiz = true 
        controller.navigationController?.popViewController(animated: true)
    }
    
    func returnToMenu() {
        AudioPlayer.audioQueue.async {
            while AudioPlayer.sfxAudioPlayer.isPlaying {}
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.close()
            })
        }
    }
    
    func close() {
        if let firstViewController = controller.navigationController?.viewControllers[1] {
            controller.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
}
