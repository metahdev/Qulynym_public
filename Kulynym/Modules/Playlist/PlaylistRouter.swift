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
        if view.isKaraoke {
            let karaokeView = KaraokeViewController()
            view.karaokeViewDelegate = karaokeView
            
            view.karaokeViewDelegate.content = view.content[index]
            karaokeView.transitioningDelegate = view
            
            view.present(karaokeView, animated: true, completion: nil)
        } else {
            let storyView = StoryViewController()
            view.storyViewDelegate = storyView 
            
            view.storyViewDelegate.content = ContentService.stories[index]
            storyView.transitioningDelegate = view
            
            view.present(storyView, animated: true, completion: nil)
        }
    }
}
