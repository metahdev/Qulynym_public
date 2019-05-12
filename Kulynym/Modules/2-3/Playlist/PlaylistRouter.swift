//
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
    func presentKaraoke(_ song: Playlist)
    func presentStory(_ story: Story)
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
        view.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func presentKaraoke(_ song: Playlist) {
        
    }
    
    func presentStory(_ story: Story) {
        
    }
}
