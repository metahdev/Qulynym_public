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
    func dataIsReady()
}

class DataFetchAPI {
    // MARK:- Properties
    var beineler = [Beine]()
    var token: String?
    var isLoadingBegan = false
    
    private weak var fetchAPIDelegate: DataFetchAPIDelegate?
    private weak var connectionDelegate: ConnectionWarningCaller?
    
    private var stringURL: String!
    private var idKey: String!
    private var fetchIDKey: String!
    private var fetchIDValue: String!
    private var parameters: [String: String]!
    
    private var tempData: [Beine]!
    
    private let apiKey = "AIzaSyBPpfghleZOpf0m4vw69sJ8t2zxvvxmj8w"
    private var alamofireManager: Session?

    
    // MARK:- Initialization
    required init(fetchAPIDelegate: DataFetchAPIDelegate, connectionDelegate: ConnectionWarningCaller) {
        self.fetchAPIDelegate = fetchAPIDelegate
        self.connectionDelegate = connectionDelegate
    }
    
    
    // MARK:- Methods
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
        stringURL = "https://www.googleapis.com/youtube/v3/playlists"
        idKey = "id"
        fetchIDKey = "channelId"
        fetchIDValue = "UCSJKvyZVC0FLiyvo3LeEllg"
        parameters = [String: String]()
        tempData = [Beine]()
    }
    
    private func definingPlaylistRequestParameters() {
        if let id = self.fetchAPIDelegate!.playlistID {
            stringURL = stringURL.replacingOccurrences(of: "playlists", with: "playlistItems")
            idKey = "snippet.resourceId.videoId"
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
//        setupConfiguration()
        
        AF.request(stringURL,
                   method: .get,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder(destination: .queryString),
                   headers: nil)
            .responseJSON(completionHandler: { response in

            switch response.result {
            case .success(let value):
                self.parsingJSON(value as? [String: Any])
            case .failure(_):
                self.connectionDelegate?.showAnErrorMessage()
            }
            self.isLoadingBegan = false
        })
    }
    
    private func setupConfiguration() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        alamofireManager = Alamofire.Session(configuration: configuration)
    }
    
    private func parsingJSON(_ value: [String: Any]?) {
        if let JSON = value {
            guard let videos = JSON["items"] as? NSArray else { return }
            appendBeineEntities(videos)
            self.token = JSON["nextPageToken"] as? String
        }
        self.beineler += tempData
        self.fetchAPIDelegate!.dataIsReady()
    }
    
    private func appendBeineEntities(_ videos: NSArray) {
        for video in videos {
            let title = (video as AnyObject).value(forKeyPath: "snippet.title") as! String
            let id = (video as AnyObject).value(forKeyPath: self.idKey) as! String
            
            let imageKeyPath = "snippet.thumbnails.maxres.url"
            let convertedVideo = video as AnyObject
            if let thumbnail = convertedVideo.value(forKeyPath: imageKeyPath) as? String {
                tempData.append(Beine(title: title, id: id, thumbnailURL: thumbnail))
            }
        }
    }
}
