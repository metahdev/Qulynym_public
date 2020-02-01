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
    
    private var nextPageToken: String?
    private var firstFetchIsCompleted = false
    private var stringURL = "https://www.googleapis.com/youtube/v3/playlists"
    private let apiKey = "AIzaSyD3nA8srC9ZsfFXFTP066VP6Bmrrq9l_C0"
    
    required init(_ presenter: MenuPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MenuInteractor {
    // MARK:- Protocol Methods
    func fetchBeine()  {
        #warning("refactor this")
        var key = "channelId"
        var idKey = "id"
        var index = 0
        if fetchIDs[1] != nil {
            key = "playlistId"
            stringURL = stringURL.replacingOccurrences(of: "playlists", with: "playlistItems")
            idKey = "snippet.resourceId.videoId"
            index = 1
        }
        
        var parameters = ["part": "snippet", key: fetchIDs[index]!, "key": apiKey, "maxResults": "10"]
         
        if let token = nextPageToken {
            parameters["pageToken"] = token
        }
        
        AF.request(stringURL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder(destination: .queryString), headers: nil).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                var tempBeineler = [Beine]()
                if let JSON = value as? [String: Any] {
                    if let videos = JSON["items"] as? NSArray {
                        for video in videos {
                            let title = (video as AnyObject).value(forKeyPath: "snippet.title") as! String
                            let id = (video as AnyObject).value(forKeyPath: idKey) as! String
                            if let thumbnail = (video as AnyObject).value(forKeyPath: "snippet.thumbnails.maxres.url") as? String {
                                tempBeineler.append(Beine(title: title, id: id, thumbnailURL: thumbnail))
                            }
                            
                        }
                    }
                    self.nextPageToken = JSON["nextPageToken"] as? String
                }
                if self.nextPageToken == nil {
                    if !self.firstFetchIsCompleted {
                        self.firstFetchIsCompleted = true
                        self.beineler = tempBeineler
                    } else {
                        return 
                    }
                } else {
                    self.beineler += tempBeineler
                }
                self.presenter.dataReady()
            case .failure(let error):
                #warning("error message")
            }
        })
    }
}
