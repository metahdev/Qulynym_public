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
    var content: Section! { get set }
}

class KaraokeViewController: UIViewController, KaraokeViewProtocol {
    // MARK:- Properties
    var content: Section!
    var router: KaraokeRouterProtocol!
    
    private weak var contentLabel: UILabel!
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
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AudioPlayer.backgroundAudioPlayer.stop()
        autoLayout.initNoteView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playVideo()
        autoLayout.initLayer(player)
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = KaraokeAutoLayout(self.view)
    }
    
    private func assignViews() {
        self.contentLabel = autoLayout.contentLabel
        self.videoView = autoLayout.videoView
        self.closeBtn = autoLayout.closeBtn
    }
    
    
    // MARK: AVKit
    private func playVideo() {
        setImage()
        initPath()
        player?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(videoEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }

    private func setImage() {
        contentLabel.text = content.name
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
        router.close()
    }
    
    @objc private func videoEnded() {
        let alert = Message(calling: self, showing: .success)
        alert.showAlert()
    }
}
