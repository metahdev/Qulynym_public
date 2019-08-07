//
/*
* Kulynym
* SettingsInteractor.swift
*
* Created by: Баубек on 8/5/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol SettingsInteractorProtocol: class {
    func getContent(_ isInfoForParents: Bool) -> String
    func saveMusicState(_ isChecked: Bool)
}

class SettingsInteractor: SettingsInteractorProtocol {
    weak var presenter: SettingsPresenterProtocol!
    
    required init(_ presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }
}

extension SettingsInteractor {
    // MARK:- Protocol Methods
    func getContent(_ isInfoForParents: Bool) -> String {
        return isInfoForParents ? ContentService.infoForParents : ContentService.credits
    }
    
    func saveMusicState(_ isChecked: Bool) {
        UserDefaults.standard.set(isChecked, forKey: "music playing")
    }
}
