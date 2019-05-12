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
    var section: Section! { get set }
    
    func getScenes() -> [String]
    func getTimepoints() -> [Int]
}

class ScenesInteractor: ScenesInteractorProtocol {
    // MARK:- Properties
    weak var presenter: ScenesPresenterProtocol!
    var section: Section!
    
    required init(presenter: ScenesPresenterProtocol) {
        self.presenter = presenter
    }
}

extension ScenesInteractor {
    // MARK:- Protocol Methods
    func getScenes() -> [String] {
        return section.scenesNames
    }
    
    func getTimepoints() -> [Int] {
        return section.scenesTimepoints
    }
}
