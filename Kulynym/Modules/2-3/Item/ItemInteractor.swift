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
    func fillContent(with slideCount: Int, with contentNames: [String]) -> String
}

class ItemInteractor: ItemInteractorProtocol {
    // MARK:- Properties
    weak var presenter: ItemPresenterProtocol!
    
    required init(presenter: ItemPresenterProtocol) {
        self.presenter = presenter
    }
}

extension ItemInteractor {
    // MARK:- Protocol Methods
    func fillContent(with slideCount: Int, with contentNames: [String]) -> String {
        return contentNames[slideCount]
    }
}
