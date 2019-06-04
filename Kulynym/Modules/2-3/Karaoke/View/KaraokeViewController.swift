/*
* Kulynym
* KaraokeViewController.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import AVKit

protocol KaraokeViewProtocol: class {
    var content: Playlist! { get set }
}

class KaraokeViewController: UIViewController, KaraokeViewProtocol {
    // MARK:- Properties
    var content: Playlist!
    var presenter: KaraokePresenterProtocol!
    
    private weak var gramophoneImage: UIImageView!
    private weak var contentImage: UIImageView!
    private weak var videoView: UIView!
    private weak var closeBtn: UIButton!
    
    private var player: AVPlayer?
    
    private let configurator: KaraokeConfiguratorProtocol = KaraokeConfigurator()
    private var autoLayout: KaraokeAutoLayoutProtocol!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        autoLayout.setupLayout()
        assignViews()
        initLayer()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
        playVideo()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = KaraokeAutoLayout(self.view)
    }
    
    private func assignViews() {
        autoLayout.gramophoneImage = self.gramophoneImage
        autoLayout.contentImage = self.contentImage
        autoLayout.videoView = self.videoView
        autoLayout.closeBtn = self.closeBtn
    }
    
    private func initLayer (){
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.frame = videoView.bounds
        layer.videoGravity = .resizeAspectFill
        
        videoView.layer.addSublayer(layer)
    }
    

    // MARK:- Animation
    private func startAnimation() {
        autoLayout.initNoteView() 
    }
    
    
    // MARK: AVKit
    private func playVideo() {
        setImage()
        
        initPath()
        
        player?.play()
    }

    private func setImage() {
        contentImage.image = UIImage(named: content.name)
    }
    
    private func initPath() {
        let videoString = Bundle.main.path(forResource: content.name, ofType: "mp4")
        guard let unwrappedVideoPath = videoString else { return }
        
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        self.player = AVPlayer(url: videoUrl)
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.closeView() 
    }
}
