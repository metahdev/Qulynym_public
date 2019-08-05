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
    var index: Int { get set }
    var maxIndex: Int { get set }
    
    func setViewsProperties()
    func playVideo()
}

class KaraokeViewController: UIViewController, KaraokeViewControllerProtocol {
    // MARK:- Properties
    var content: String!
    var index = 0
    var maxIndex = 0
    var presenter: KaraokePresenterProtocol!
    var player: AVPlayer?
    
    private weak var contentLabel: UILabel!
    private weak var backBtn: UIButton!
    private weak var videoView: UIView!
    private weak var nextBtn: UIButton!
    private weak var closeBtn: UIButton!
    
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
        presenter.getMaxCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewsProperties()
        AudioPlayer.backgroundAudioPlayer.stop()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playVideo()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        karaokeView = KaraokeView(self.view)
    }
    
    private func assignViews() {
        self.contentLabel = karaokeView.contentLabel
        self.backBtn = karaokeView.backBtn
        self.videoView = karaokeView.videoView
        self.nextBtn = karaokeView.nextBtn
        self.closeBtn = karaokeView.closeBtn
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc
    private func backBtnPressed() {
        presenter.backToPreviousVideo()
    }
    
    @objc
    private func nextBtnPressed() {
        presenter.nextVideo()
    }
    
    @objc
    private func closeBtnPressed() {
        presenter.close()
    }
    
    @objc
    private func videoEnded() {
        presenter.close()
    }
}


extension KaraokeViewController {
    // MARK:- Protocol Methods
    func setViewsProperties() {
        contentLabel.text = content
        backBtn.isEnabled = (index != 0)
        nextBtn.isEnabled = (index != maxIndex)
    }
    
    // MARK: AVKit
    func playVideo() {
        player = nil
        karaokeView.removeLayer()
        initPath()
        player?.play()
        karaokeView.initLayer(player)
        NotificationCenter.default.addObserver(self, selector: #selector(videoEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    
    private func initPath() {
        let videoString = Bundle.main.path(forResource: content, ofType: "mp4")
        guard let unwrappedVideoPath = videoString else { return }
        
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        self.player = AVPlayer(url: videoUrl)
    }
}
