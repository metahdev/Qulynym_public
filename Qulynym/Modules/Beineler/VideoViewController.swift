/*
* Qulynym
* VideoViewController.swift
*
* Created by: Metah on 10/20/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol VideoViewControllerProtocol: class {
    var videoURL: URL! { get set }
}

class VideoViewController: UIViewController,VideoViewControllerProtocol {
    // MARK:- Properties
    var videoURL: URL!
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    private lazy var videoView: UIView = {
        return UIView()
    }()
    private lazy var otherVideos: UICollectionView = {
        return configureImagesCollectionView(scroll: .horizontal, image: nil, background: nil)
    }()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
