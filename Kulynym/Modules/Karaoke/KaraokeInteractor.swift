//
/*
* Kulynym
* KaraokeInteractor.swift
*
* Created by: Metah on 8/4/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol KaraokeInteractorProtocol: class {
    func getMaxCount() -> Int
    func getLyricsText(_ index: Int) -> String
    func getPreviousAudioName(_ index: inout Int) -> String
    func getNextAudioName(_ index: inout Int) -> String
}

class KaraokeInteractor: KaraokeInteractorProtocol {
    weak var presenter: KaraokePresenterProtocol!
    
    required init(_ presenter: KaraokePresenterProtocol) {
        self.presenter = presenter
    }
}

extension KaraokeInteractor {
    // MARK:- Protocol Methods
    func getMaxCount() -> Int {
        return ContentService.songs.count - 1
    }
    
    func getLyricsText(_ index: Int) -> String {
        return ContentService.songs[index].1
    }
    
    func getPreviousAudioName(_ index: inout Int) -> String {
        index -= 1
        return ContentService.songs[index].0
    }
    
    func getNextAudioName(_ index: inout Int) -> String {
        index += 1
        return ContentService.songs[index].0
    }
}
