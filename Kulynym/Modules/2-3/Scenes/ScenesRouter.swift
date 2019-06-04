/*
* Kulynym
* ScenesRouter.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesRouterProtocol: class {
    func presentItemVC(contentNames: [String])
    func presentPlaylistVC(isKaraoke: Bool)
    func presentDrawing() 
}

class ScenesRouter: ScenesRouterProtocol {
    // MARK:- Properties
    weak var view: ScenesViewController!
    
    required init(view: ScenesViewController) {
        self.view = view
    }
}

extension ScenesRouter {
    // MARK:- Protocol Methods
    func presentItemVC(contentNames: [String]) {
        let itemView = ItemViewController()
        view.itemViewDelegate = itemView
        itemView.contentNames = contentNames
        itemView.transitioningDelegate = view
        
        view.present(itemView, animated: true, completion: nil)
    }
    
    func presentPlaylistVC(isKaraoke: Bool) {
        let playlistView = PlaylistViewController()
        view.playlistViewDelegate = playlistView
        playlistView.isKaraoke = isKaraoke
        playlistView.transitioningDelegate = view
        
        view.present(playlistView, animated: true, completion: nil)
    }
    
    func presentDrawing() {
    }
}
