/*
 * Qulynym
 * ItemInteractor.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ItemInteractorProtocol: class {
    func getShuffledCards(from content: [String]) -> [String]
    func getSlideCount(section name: String) 
}

class ItemInteractor: ItemInteractorProtocol {
    // MARK:- Properties
    weak var presenter: ItemPresenterProtocol!
    
    required init(_ presenter: ItemPresenterProtocol) {
        self.presenter = presenter
    }
}

extension ItemInteractor {
    // MARK:- Protocol Methods
    func getSlideCount(section name: String)  {
        presenter.slideCount = (UserDefaults.standard.value(forKey: name) as? Int ?? 0)
        var eduSection: EduSection!
        _ = ContentService.toddlerSections.map({
            if $0.name == name {
                eduSection = $0
            }
        })
        if eduSection.contentNames.count == presenter.slideCount {
            UserDefaults.standard.setValue(0, forKey: name)
            presenter.slideCount = 0
        }
    }
    
    func getShuffledCards(from content: [String]) -> [String] {
        return content[presenter.slideCount - 4...presenter.slideCount - 1].shuffled()
    }
}
