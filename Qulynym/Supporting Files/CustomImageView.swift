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

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    private var alamofireManager: Session?
    
    func loadImageUsingUrlString(urlString: String, warningCaller: ConnectionWarningCaller){
        imageUrlString = urlString
        image = nil
                
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            self.hideSkeleton()
            return
        }
        
        guard Connectivity.isConnectedToInternet else {
            warningCaller.showAnErrorMessage()
            return
        }
    
        let url = URL(string: urlString)!
        AF.request(url).responseData {(response) in
            guard response.error == nil else {
                warningCaller.showAnErrorMessage()
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
                }
            }
        }
    }
}
