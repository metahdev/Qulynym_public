/*
* Kulynym
* PlaylistInteractor.swift
*
* Created by: Metah on 5/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol PlaylistInteractorProtocol: class {
    func getContent(_ isKaraoke: Bool) -> [String]
}

class PlaylistInteractor: PlaylistInteractorProtocol {
    // MARK:- Properties
    weak var presenter: PlaylistPresenterProtocol!
    
    required init(_ presenter: PlaylistPresenterProtocol) {
        self.presenter = presenter
    }
}

extension PlaylistInteractor {
    // MARK:- Protocol Methods
    func getContent(_ isKaraoke: Bool) -> [String] {
        if isKaraoke {
            var songNames = [String]()
            ContentService.songs.map({(songName, _) in
                songNames.append(songName)
            })
            return songNames
        } else {
            return ContentService.stories
        }
    }
}

