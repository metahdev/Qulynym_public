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
        if controller.itemView.slideCount == controller.itemView.section.contentNames.count {
            close()
            return
        }
        controller.navigationController?.popViewController(animated: true)
    }
    
    func close() {
        if let firstViewController = controller.navigationController?.viewControllers[1] {
            controller.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
}
