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

#warning("refactor")
let imageCache = NSCache<NSString, UIImage>()
class CustomImageView: UIImageView {
    var imageUrlString: String?
    private var secondsToFetch = 0
    private var timer: Timer?
    private var result: Responce?
    
    func loadImageUsingUrlString(urlString: String) -> Responce? {
        imageUrlString = urlString
        let url = URL(string: urlString)!
        image = nil
        result = nil
                
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            self.hideSkeleton()
            return .success
        }
        
        AF.request(url).responseData {(response) in
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
    
    private func initTimer() {
        timer = Timer(timeInterval: 1, repeats: true) { [weak self] _ in
            self?.checkState()
        }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func checkState() {
        secondsToFetch += 1
        
        if (secondsToFetch == 10) {
            self.result = .failure
            self.timer?.invalidate()
            self.timer = nil
            self.secondsToFetch = 0
        }
    }
}
