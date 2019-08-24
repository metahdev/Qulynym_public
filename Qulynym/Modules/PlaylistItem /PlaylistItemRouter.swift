/*
 * Qulynym
 * PlaylistItemRouter.swift
 *
 * Created by: Metah on 5/30/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol PlaylistItemRouterProtocol: class {
    func close()
}

class PlaylistItemRouter: PlaylistItemRouterProtocol {
    // MARK:- Properties
    weak var controller: PlaylistItemViewController!
    
    required init(_ controller: PlaylistItemViewController) {
        self.controller = controller
    }
}

extension PlaylistItemRouter {
    func close() {
        AudioPlayer.playlistItemAudioPlayer.stop()
        controller.navigationController?.popViewController(animated: true)
        if AudioPlayer.backgroundAudioStatePlaying {
            AudioPlayer.backgroundAudioPlayer.play()
        }
    }
}
