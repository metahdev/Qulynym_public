/*
* Qulynym
* DataFetchAPI.swift
*
* Created by: Metah on 2/2/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Alamofire
import SwiftyJSON

struct Beine {
    var title: String
    var id: String
    var thumbnailURL: String
}

protocol DataFetchAPIDelegate: class {
    var playlistID: String? { get set }
    func dataIsReady()
}

class DataFetchAPI {
    // MARK:- Properties
    var beineler = [Beine]()
    var token: String?
    var isLoadingBegan = false
    
    private weak var fetchAPIDelegate: DataFetchAPIDelegate?
    private weak var connectionDelegate: ConnectionWarningCaller?
    
    private var inPlaylist = false
    private var stringURL: String!
    private var fetchIDKey: String!
    private var fetchIDValue: String!
    private var parameters: [String: String]!
    
    private var tempData: [Beine]!
    
    private let apiKey = "AIzaSyCsNKMuOVN7DF6j2U0lmKfNF8Gup9q55ck"
    private var alamofireManager: Session?

    
    // MARK:- Initialization
    required init(fetchAPIDelegate: DataFetchAPIDelegate, connectionDelegate: ConnectionWarningCaller) {
        self.fetchAPIDelegate = fetchAPIDelegate
        self.connectionDelegate = connectionDelegate
        
        setupConfiguration()
    }
    
    private func setupConfiguration() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        alamofireManager = Alamofire.Session(configuration: configuration)
    }
    
    
    // MARK:- Methods
    func nullifyData() {
        beineler.removeAll()
    }
    
    func fetchBeine() {
        guard self.fetchAPIDelegate != nil else { return }
        guard let connectionDelegate = self.connectionDelegate else { return }
        guard Connectivity.isConnectedToInternet else {
            connectionDelegate.showAnErrorMessage()
            return
        }
        guard isLoadingBegan == false else { return }
        
        assignVariablesStartingValues()
        definingPlaylistRequestParameters()
        defineLoadingStateAndParameters()
        
        makeRequest()
    }
    
    private func assignVariablesStartingValues() {
        inPlaylist = false
        stringURL = "https://www.googleapis.com/youtube/v3/playlists"
        fetchIDKey = "channelId"
        fetchIDValue = "UCSJKvyZVC0FLiyvo3LeEllg"
        parameters = [String: String]()
        tempData = [Beine]()
    }
    
    private func definingPlaylistRequestParameters() {
        if let id = self.fetchAPIDelegate!.playlistID {
            stringURL = stringURL.replacingOccurrences(of: "playlists", with: "playlistItems")
            inPlaylist = true
            fetchIDKey = "playlistId"
            fetchIDValue = id
        }
    }
    
    private func defineLoadingStateAndParameters() {
        isLoadingBegan = true
        parameters = ["part": "snippet", fetchIDKey: fetchIDValue, "key": apiKey, "maxResults": "5"]
        if let token = self.token {
            parameters["pageToken"] = token
        }
    }
    
    private func makeRequest() {
        alamofireManager!.request(stringURL,
                   method: .get,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder(destination: .queryString),
                   headers: ["x-ios-bundle-identifier": "com.devmetah.qulynym"])
            .responseJSON(completionHandler: { response in

            switch response.result {
            case .success(let value):
                self.parsing(JSON(value))
            case .failure(_):
                self.connectionDelegate?.showAnErrorMessage()
            }
            self.isLoadingBegan = false
        })
    }
    
    private func parsing(_ json: JSON) {
        let videos = json["items"]
        appendBeineEntities(videos)
        self.token = json["nextPageToken"].string
        self.beineler += tempData
        self.fetchAPIDelegate?.dataIsReady()
    }
    
    private func appendBeineEntities(_ videos: JSON) {
        for (_, subJson): (String, JSON) in videos {
            let title = subJson["snippet"]["title"].string ?? ""
            
            var id = ""
            if inPlaylist {
                id = subJson["snippet"]["resourceId"]["videoId"].string ?? ""
            } else {
                id = subJson["id"].string ?? ""
            }
            
            if let thumbnail = subJson["snippet"]["thumbnails"]["maxres"]["url"].string {
                tempData.append(Beine(title: title, id: id, thumbnailURL: thumbnail))
            }
        }
    }
}
