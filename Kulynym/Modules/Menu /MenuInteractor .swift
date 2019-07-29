/*
* Kulynym
* MenuInteractor .swift
*
* Created by: Metah on 6/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

protocol MenuInteractorProtocol: class {
    func getSections(_ type: Menu) -> [Section]
}

class MenuInteractor: MenuInteractorProtocol {
    /// MARK:- Properties
    weak var presenter: MenuPresenterProtocol!
    
    required init(_ presenter: MenuPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MenuInteractor {
    // MARK:- Protocol Methods
    func getSections(_ type: Menu) -> [Section] {
        if type == .toddler {
            return ContentService.toddlerSections
        } else if type == .main {
            return ContentService.menuSections
        }
        return ContentService.gamesSection
    }
}
