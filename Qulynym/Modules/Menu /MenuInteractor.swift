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
    var beineler: [Beine] { get }
   
    func fetchBeine()
}

class MenuInteractor: MenuInteractorProtocol {
    /// MARK:- Properties
    weak var presenter: MenuPresenterProtocol!
    var beineler = [Beine]()
    
    var fetchIDs = ["UCSJKvyZVC0FLiyvo3LeEllg", nil]
    private let apiKey = "AIzaSyD3nA8srC9ZsfFXFTP066VP6Bmrrq9l_C0"
    private let stringURL = "https://www.googleapis.com/youtube/v3/playlists"
    
    required init(_ presenter: MenuPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MenuInteractor {
    // MARK:- Protocol Methods
    func fetchBeine()  {
        #warning("refactor this")
        /* make several requests by nextPageToken(the maxResults 50 isn't working with the 7th element giving the name of 6th, output of titles:
         «Сәби» мультхикаясы (2019)
         Абай Құнанбайұлының 175 жылдығы
         «Таңжарық» бағдарламасы (2019)
         «Ертемір» мультхикаясы (2019 ж.) 2-маусым
         «Айдар» мультхикаясы (2019 ж.) 2-маусым
         «Немене» телехикаясы
         Немене * Unexpectedly found nil while unwrapping an Optional value * error occurs
         )
         */
        
        #warning("by some reason the beineler menu is showing playlists again")
        var key = ""
        var index = 0
        if fetchIDs[1] == nil {
            key = "channelId"
        } else {
            key = "id"
            index = 1
        }
        
        AF.request(stringURL, method: .get, parameters: ["part": "snippet", key: fetchIDs[index], "key": apiKey], encoder: URLEncodedFormParameterEncoder(destination: .queryString), headers: nil).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any] {
                    if let videos = JSON["items"] as? NSArray {
                        print(JSON)
                        for video in videos {
                            let title = (video as AnyObject).value(forKeyPath: "snippet.title") as! String
                            let id = (video as AnyObject).value(forKeyPath: "id") as! String
                            let thumbnail = (video as AnyObject).value(forKeyPath: "snippet.thumbnails.maxres.url") as! String
                            self.beineler.append(Beine(title: title, id: id, thumbnailURL: thumbnail))
                        }
                    }
                }
                self.presenter.dataReady() 
            case .failure(let error):
                #warning("error message")
            }
        })
    }
}
