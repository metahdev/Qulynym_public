/*
* Qulynym
* BeineViewController.swift
*
* Created by: Metah on 10/20/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import YoutubePlayer_in_WKWebView


protocol VideoViewControllerProtocol: class {
    var videoID: String! { get set }
}

#warning("rethink UI: youtube player, view borders and background color")
class BeineViewController: UIViewController,VideoViewControllerProtocol {
    // MARK:- Properties
    var videoID: String!
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    private lazy var videoView: WKYTPlayerView = {
        let view = WKYTPlayerView()
        view.delegate = self
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    private lazy var recommendationsCV: UICollectionView = {
        return configureImagesCollectionView(scroll: .horizontal, image: nil, background: nil)
    }()
    private lazy var nextVideoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "nextVideo"), for: .normal)
        return btn
    }()
    private lazy var previousVideoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "previousVideo"), for: .normal)
        return btn
    }()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoView)
        view.addSubview(closeBtn)
        view.addSubview(recommendationsCV)
        view.addSubview(nextVideoBtn)
        view.addSubview(previousVideoBtn)
        setupCV()
        setAutoresizingFalse()
        activateConstraints()
        closeBtn.configureCloseBtnFrame(view)
        closeBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        view.backgroundColor = .black
    }
    
    //to hide recommendations when video is finished and info 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let playvarsDic = ["controls": 0, "playsinline": 1, "showinfo": 0, "autoplay": 1, "rel": 0]
        videoView.load(withVideoId: videoID, playerVars: playvarsDic)
        AudioPlayer.backgroundAudioPlayer.pause()
    }
    
    private func setupCV() {
        recommendationsCV.delegate = self
        recommendationsCV.dataSource = self
    }
    
    private func setAutoresizingFalse() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false 
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            videoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            videoView.topAnchor.constraint(equalTo: view.topAnchor),
            videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextVideoBtn.leadingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: 16),
            nextVideoBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.05),
            nextVideoBtn.heightAnchor.constraint(equalTo: nextVideoBtn.widthAnchor),
            nextVideoBtn.centerYAnchor.constraint(equalTo: videoView.centerYAnchor),
            
            previousVideoBtn.trailingAnchor.constraint(equalTo: videoView.leadingAnchor, constant: -16),
            previousVideoBtn.widthAnchor.constraint(equalTo: nextVideoBtn.widthAnchor),
            previousVideoBtn.heightAnchor.constraint(equalTo: previousVideoBtn.widthAnchor),
            previousVideoBtn.centerYAnchor.constraint(equalTo: nextVideoBtn.centerYAnchor),
            
            recommendationsCV.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 12),
            recommendationsCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendationsCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendationsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    // MARK:- Actions
    @objc
    private func closeView() {
        self.navigationController!.popViewController(animated: true)
        AudioPlayer.backgroundAudioPlayer.play()
    }
}


extension BeineViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        
        cell.backgroundColor = .gray
        
        cell.textSize = view.frame.height * 0.1
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 15
        cell.imageViewCornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: recommendationsCV.frame.width * 0.3, height: recommendationsCV.frame.height - 8)
    }
}


extension BeineViewController: WKYTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: WKYTPlayerView) -> UIColor {
        return .clear
    }
}
