/*
* Qulynym
* DataFetchAPI.swift
*
* Created by: Metah on 2/2/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import Alamofire

protocol DataFetchAPIDelegate: class {
    var playlistID: String? { get set }
    var isPassingSafe: Bool { get set }
    var isConnectionErrorShowing: Bool { get set }
    func dataIsReady()
    func showAnErrorMessage()
}

class DataFetchAPI {
    // MARK:- Properties
    var beineler = [Beine]()
    var token: String?
    var isLoadingBegan = false
    
    private var firstFetchIsCompleted = false
    private var stringURL = "https://www.googleapis.com/youtube/v3/playlists"
    private let apiKey = "AIzaSyD3nA8srC9ZsfFXFTP066VP6Bmrrq9l_C0"
    
    private weak var delegate: DataFetchAPIDelegate?

    required init(delegate: DataFetchAPIDelegate) {
        self.delegate = delegate
    }
    
    // MARK:- Methods
    func fetchBeine() {
        guard let delegate = self.delegate else { return }
        guard Connectivity.isConnectedToInternet else {
            delegate.showAnErrorMessage()
            return 
        }
        
        isLoadingBegan = true
        var fetchIDKey = "channelId"
        var fetchIDValue = "UCSJKvyZVC0FLiyvo3LeEllg"
        var idKey = "id"
        
        if let id = delegate.playlistID {
            fetchIDKey = "playlistId"
            fetchIDValue = id
            idKey = "snippet.resourceId.videoId"
            stringURL = stringURL.replacingOccurrences(of: "playlists", with: "playlistItems")
        }
        
        var parameters = ["part": "snippet", fetchIDKey: fetchIDValue, "key": apiKey, "maxResults": "5"]
         
        if let token = self.token {
            parameters["pageToken"] = token
        }
        
        #warning("refactor")
        delegate.isPassingSafe = false
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
                    self.token = JSON["nextPageToken"] as? String
                }
                self.beineler += tempBeineler
                delegate.dataIsReady()
                self.isLoadingBegan = false
            case .failure(_):
                delegate.showAnErrorMessage()
            }
        })        
    }    
}
