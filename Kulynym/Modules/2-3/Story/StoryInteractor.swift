//
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
    
    required init(_ presenter: StoryPresenterProtocol) {
        self.presenter = presenter
    }
}
