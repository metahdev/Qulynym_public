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
    weak var view: PlaylistViewController!
    
    required init(view: PlaylistViewController) {
        self.view = view
    }
}

extension PlaylistRouter {
    // MARK:- Protocol Methods
    func close() {
        view.dismiss(animated: true, completion: nil)
    }
    
    func presentContent(_ index: Int) {
        let karaokeView = KaraokeViewController()
        view.karaokeViewDelegate = karaokeView
        
        if view.isKaraoke {
            view.karaokeViewDelegate.content = view.content[index]
            karaokeView.transitioningDelegate = view
            
            view.present(karaokeView, animated: true, completion: nil)
        } else {
        }
    }
}
