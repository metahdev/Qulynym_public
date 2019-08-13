/*
* Kulynym
* StoryInteractor.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol StoryInteractorProtocol: class {
    func getMaxCount() -> Int
    func getPreviousVideo(_ index: inout Int) -> String
    func getNextVideo(_ index: inout Int) -> String
}

class StoryInteractor: StoryInteractorProtocol {
    // MARK:- Properties
    weak var presenter: StoryPresenterProtocol!
    var index = 0
    
    required init(_ presenter: StoryPresenterProtocol) {
        self.presenter = presenter
    }
}

extension StoryInteractor {
    // MARK:- Protocol Methods
    func getMaxCount() -> Int {
        return ContentService.stories.count - 1
    }
    
    func getPreviousVideo(_ index: inout Int) -> String {
        index -= 1
        return ContentService.songs[index]
    }
    
    func getNextVideo(_ index: inout Int) -> String {
        index += 1
        return ContentService.songs[index]
    }
}
