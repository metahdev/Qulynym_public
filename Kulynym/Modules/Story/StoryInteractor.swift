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
}

class StoryInteractor: StoryInteractorProtocol {
    // MARK:- Properties
    weak var presenter: StoryPresenterProtocol!
    var index = -1
    
    required init(_ presenter: StoryPresenterProtocol) {
        self.presenter = presenter
    }
}

extension StoryInteractor {
    // MARK:- Protocol Methods
}
