/*
* Kulynym
* PlaylistRouter.swift
*
* Created by: Metah on 5/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol PlaylistRouterProtocol: class {
    func close()
    func presentContent(_ index: Int)
}

class PlaylistRouter: PlaylistRouterProtocol {
    // MARK:- Properties
    weak var controller: PlaylistViewController!
    
    required init(_ controller: PlaylistViewController) {
        self.controller = controller
    }
}

extension PlaylistRouter {
    // MARK:- Protocol Methods
    func close() {
        controller.navigationController!.popViewController(animated: true)
    }
    
    func presentContent(_ index: Int) {
        let karaokeView = KaraokeViewController()
        controller.karaokeViewDelegate = karaokeView
            
        controller.karaokeViewDelegate.contentName = controller.content[index]
        controller.karaokeViewDelegate.index = index
        controller.karaokeViewDelegate.isKaraoke = controller.isKaraoke
        karaokeView.transitioningDelegate = controller
            
        controller.show(karaokeView, sender: nil)
    }
}
