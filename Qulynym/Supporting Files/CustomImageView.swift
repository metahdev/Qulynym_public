/*
* Qulynym
* CustomImageView.swift
*
* Created by: Metah on 2/8/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit
import Alamofire
import SkeletonView

enum Responce {
    case success
    case failure
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    private var result: Responce?
    private var alamofireManager: Session?
    
    func loadImageUsingUrlString(urlString: String, warningCaller: ConnectionWarningCaller) -> Responce? {
        imageUrlString = urlString
        image = nil
        result = nil
                
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            self.hideSkeleton()
            return .success
        }
        
        guard Connectivity.isConnectedToInternet else {
            return .failure
        }

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        alamofireManager = Alamofire.Session(configuration: configuration)

        alamofireManager!.request(URL(string: urlString)!).responseData {(response) in
            guard response.error == nil else {
                self.result = .failure
                return
            }

            if let data = response.data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                    self.hideSkeleton(transition: .crossDissolve(0.25))
                    
                    self.result = .success
                }
            }
        }

        return result
    }
}
