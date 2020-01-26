/*
* Qulynym
* MenuInteractor .swift
*
* Created by: Metah on 6/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import Alamofire

protocol MenuInteractorProtocol: class {
    func getStringSections(_ type: Menu) -> [String]
    func getEduSections() -> [EduSection]
}

class MenuInteractor: MenuInteractorProtocol {
    /// MARK:- Properties
    weak var presenter: MenuPresenterProtocol!
    var playlistURL: String!
    private let apiKey = "AIzaSyAxwDKck_8Ve5hrqIZfaJK1lgoVmGc4qr0"
    
    required init(_ presenter: MenuPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MenuInteractor {
    // MARK:- Protocol Methods
    func getStringSections(_ type: Menu) -> [String] {
        if type == .main {
            return ContentService.menuSections
        }
        return ContentService.gamesSection
    }
    
    func getEduSections() -> [EduSection] {
        return ContentService.toddlerSections
    }
    
    func fetchPlaylistVideos() {
        
    }
}
