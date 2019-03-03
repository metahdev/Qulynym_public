/*
 * Kulynym
 * ItemInteractor.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol ItemInteractorProtocol: class {
    func fillContent(with slideCount: Int, with category: String) -> String
}

class ItemInteractor: ItemInteractorProtocol {
    weak var presenter: ItemPresenterProtocol!
    
    required init(presenter: ItemPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fillContent(with slideCount: Int, with category: String) -> String {
        return ContentService.contentNames[category]![slideCount]
    }
}
