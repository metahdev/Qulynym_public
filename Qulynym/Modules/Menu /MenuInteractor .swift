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
    var playlistID = "PLm8b4TrIR2AcXTsUw9BrBcL4552pE6wA2"
    private let apiKey = "AIzaSyAxwDKck_8Ve5hrqIZfaJK1lgoVmGc4qr0"
    private let stringURL = "https://www.googleapis.com/youtube/v3/playlists"
    
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
        AF.request(stringURL, method: .get, parameters: ["part": "snippet", "playlistID": playlistID, "key": apiKey], encoder: URLEncodedFormParameterEncoder(destination: .queryString), headers: nil).responseJSON(completionHandler: { response in
            
            guard response.error == nil else {
                #warning("show an error message")
                return
            }
            
            if let json = response.value as? NSDictionary {
                print(json)
            }
        })
    }
}
