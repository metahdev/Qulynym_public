/*
 * Qulynym
 * SettingsInteractor.swift
 *
 * Created by: Baubek on 8/5/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol SettingsInteractorProtocol: class {
    func getContent(_ isInfoForParents: Bool) -> NSAttributedString
    func getTitle(_ isInfoForParents: Bool) -> String
    func saveMusicState(_ isChecked: Bool)
    func getMusicState() -> Bool?
}

class SettingsInteractor: SettingsInteractorProtocol {
    weak var presenter: SettingsPresenterProtocol!
    
    required init(_ presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }
}

extension SettingsInteractor {
    // MARK:- Protocol Methods
    func getContent(_ isInfoForParents: Bool) -> NSAttributedString {
        return isInfoForParents ? Content.infoForParents : Content.credits
    }
    
    func getTitle(_ isInfoForParents: Bool) -> String {
        return isInfoForParents ? "Ata-analarg'a" : "Siltemeler"
    }
    
    func saveMusicState(_ isChecked: Bool) {
        AudioPlayer.backgroundAudioStatePlaying = isChecked
    }
    
    func getMusicState() -> Bool? {
        return AudioPlayer.backgroundAudioStatePlaying 
    }
}
