 /*
* Qulynym
* PlaylistItemInteractor.swift
*
* Created by: Metah on 8/4/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
 */

import Foundation

protocol PlaylistItemInteractorProtocol: class {
    func getMaxCount(_ isKaraoke: Bool) -> Int
    func getLyricsText(_ index: Int) -> [String]
    func getPreviousAudioName(_ index: inout Int, isKaraoke: Bool) -> String
    func getNextAudioName(_ index: inout Int, isKaraoke: Bool) -> String
}

class PlaylistItemInteractor: PlaylistItemInteractorProtocol {
    weak var presenter: PlaylistItemPresenterProtocol!
    
    required init(_ presenter: PlaylistItemPresenterProtocol) {
        self.presenter = presenter
    }
}

extension PlaylistItemInteractor {
    // MARK:- Protocol Methods
    func getMaxCount(_ isKaraoke: Bool) -> Int {
        if isKaraoke {
            return Content.songs.count - 1
        }
        return Content.stories.count - 1
    }
    
    func getLyricsText(_ index: Int) -> [String] {
        return Content.songs[index].lyrics
    }
    
    func getPreviousAudioName(_ index: inout Int, isKaraoke: Bool) -> String {
        index -= 1
        if isKaraoke {
            return Content.songs[index].name
        }
        return Content.stories[index]
    }
    
    func getNextAudioName(_ index: inout Int, isKaraoke: Bool) -> String {
        index += 1
        if isKaraoke {
            return Content.songs[index].name
        }
        return Content.stories[index]
    }
}
