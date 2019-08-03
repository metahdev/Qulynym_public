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

protocol KaraokeViewControllerProtocol: class {
    var content: String! { get set }
}

class KaraokeViewController: UIViewController, KaraokeViewControllerProtocol {
    // MARK:- Properties
    var content: String!
    var presenter: KaraokePresenterProtocol!
    
    private weak var contentLabel: UILabel!
    private weak var videoView: UIView!
    private weak var closeBtn: UIButton!
    
    private var player: AVPlayer?
    
    private let configurator: KaraokeConfiguratorProtocol = KaraokeConfigurator()
    private var karaokeView: KaraokeViewProtocol!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        karaokeView.setupLayout()
        assignViews()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AudioPlayer.backgroundAudioPlayer.stop()
        karaokeView.initNoteView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playVideo()
        karaokeView.initLayer(player)
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        karaokeView = KaraokeView(self.view)
    }
    
    private func assignViews() {
        self.contentLabel = karaokeView.contentLabel
        self.videoView = karaokeView.videoView
        self.closeBtn = karaokeView.closeBtn
    }
    
    
    // MARK: AVKit
    private func playVideo() {
        setImage()
        initPath()
        player?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(videoEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }

    private func setImage() {
        contentLabel.text = content
    }
    
    private func initPath() {
        let videoString = Bundle.main.path(forResource: content, ofType: "mp4")
        guard let unwrappedVideoPath = videoString else { return }
        
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        self.player = AVPlayer(url: videoUrl)
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.close()
    }
    
    @objc private func videoEnded() {
        presenter.close()
    }
}
