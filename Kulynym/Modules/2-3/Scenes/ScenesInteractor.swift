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
    var category: String! { get set }
    
    func getScenes() -> [String]
    func getTimepoints() -> [Int]
}

class ScenesInteractor: ScenesInteractorProtocol {
    weak var presenter: ScenesPresenterProtocol!
    var category: String!
    
    required init(presenter: ScenesPresenterProtocol) {
        self.presenter = presenter
    }
}

extension ScenesInteractor {
    // MARK:- Protocol Methods
    func getScenes() -> [String] {
        return ContentService.scenesNames[category]!
    }
    
    func getTimepoints() -> [Int] {
        return ContentService.timepoints[category]!
    }
}
