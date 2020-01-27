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
    var fetchIDs: [String?] { get set }
   
    func fetchBeine() -> [Beine]
}

class MenuInteractor: MenuInteractorProtocol {
    /// MARK:- Properties
    weak var presenter: MenuPresenterProtocol!
    
    var fetchIDs = ["UCSJKvyZVC0FLiyvo3LeEllg", nil]
    private let apiKey = "AIzaSyAxwDKck_8Ve5hrqIZfaJK1lgoVmGc4qr0"
    private let stringURL = "https://www.googleapis.com/youtube/v3/playlists"
    
    required init(_ presenter: MenuPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MenuInteractor {
    // MARK:- Protocol Methods
    func fetchBeine() -> [Beine] {
        var beineler = [Beine]()
        
        var key = ""
        var index = 0
        if fetchIDs[1] == nil {
            key = "channelId"
        } else {
            key = "id"
            index = 1
        }
        
        AF.request(stringURL, method: .get, parameters: ["part": "snippet", key: fetchIDs[index], "key": apiKey], encoder: URLEncodedFormParameterEncoder(destination: .queryString), headers: nil).responseJSON(completionHandler: { response in
            
            guard response.error == nil else {
                #warning("show an error message")
                return
            }
            
            if let json = response.value as? NSDictionary {
                print(json)
            }
        })
        
        return beineler
    }
}
