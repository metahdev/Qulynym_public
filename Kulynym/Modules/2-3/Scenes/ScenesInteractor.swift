/*
* Kulynym
* ScenesInteractor.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ScenesInteractorProtocol: class {
    func getScenes(of category: String) -> [String]
}

class ScenesInteractor: ScenesInteractorProtocol {
    weak var presenter: ScenesPresenterProtocol!
    
    required init(presenter: ScenesPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getScenes(of category: String) -> [String] {
        return ContentService.scenesNames[category]!
    }
}
