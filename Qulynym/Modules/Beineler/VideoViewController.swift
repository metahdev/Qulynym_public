/*
* Qulynym
* VideoViewController.swift
*
* Created by: Metah on 10/20/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import YoutubePlayer_in_WKWebView

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
    #warning("Layout isn't correct: buttons are hidden")
    private lazy var videoView: WKYTPlayerView = {
        let view = WKYTPlayerView()
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoView.load(withVideoId: "HluANRwPyNo")
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
            videoView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(closeBtn.frame.width * 2 + 24)),
            videoView.topAnchor.constraint(equalTo: view.topAnchor),
            videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextVideoBtn.leadingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: 16),
            nextVideoBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            nextVideoBtn.heightAnchor.constraint(equalTo: nextVideoBtn.widthAnchor),
            nextVideoBtn.centerYAnchor.constraint(equalTo: videoView.centerYAnchor),
            
            previousVideoBtn.trailingAnchor.constraint(equalTo: videoView.leadingAnchor, constant: -16),
            previousVideoBtn.widthAnchor.constraint(equalTo: nextVideoBtn.widthAnchor),
            previousVideoBtn.heightAnchor.constraint(equalTo: previousVideoBtn.widthAnchor),
            previousVideoBtn.centerYAnchor.constraint(equalTo: previousVideoBtn.centerYAnchor),
            
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
    }
}


extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: recommendationsCV.frame.width * 0.5, height: recommendationsCV.frame.height * 0.5)
    }
}
