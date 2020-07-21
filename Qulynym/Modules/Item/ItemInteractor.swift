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
    func getShuffledCards(from content: [String]) -> [String] {
        return content[presenter.slideCount - 4...presenter.slideCount - 1].shuffled()
    }
}
