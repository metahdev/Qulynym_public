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
    var contentName: String { get set }
    var lyricsText: String { get set }
    var index: Int { get set }
    var maxIndex: Int { get set }
    
    func setViewsProperties()
    func playBtnPressed()
}

class KaraokeViewController: UIViewController, KaraokeViewControllerProtocol {
    // MARK:- Properties
    var contentName = ""
    var lyricsText = ""
    var index = 0
    var maxIndex = 0
    var presenter: KaraokePresenterProtocol!
    
    private var isPlaying = false
    private let configurator: KaraokeConfiguratorProtocol = KaraokeConfigurator()
    private var karaokeView: KaraokeViewProtocol!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        karaokeView.setupLayout()
        assignActions()
        presenter.getLyricsText()
        presenter.getMaxCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViewsProperties()
        AudioPlayer.backgroundAudioPlayer.stop()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        karaokeView = KaraokeView(self.view)
    }
    
    // MARK:- Actions
    private func assignActions() {
        karaokeView.playBtn.addTarget(self, action: #selector(playBtnPressed), for: .touchUpInside)
        karaokeView.backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        karaokeView.forwardBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        karaokeView.closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        karaokeView.timelineSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func playBtnPressed() {
        if isPlaying {
            presenter.pauseAudio()
            karaokeView.playBtn.setImage(UIImage(named: "playBtn"), for: .normal)
        } else {
            presenter.playAudio()
            karaokeView.playBtn.setImage(UIImage(named: "pauseBtn"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc
    private func backBtnPressed() {
        presenter.backToPreviousAudio()
    }
    
    @objc
    private func nextBtnPressed() {
        presenter.nextAudio()
    }
    
    @objc
    private func closeBtnPressed() {
        presenter.close()
    }
    
    @objc
    private func videoEnded() {
        presenter.close()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        presenter.scrollAudio(to: sender.value)
    }
}


extension KaraokeViewController {
    // MARK:- Protocol Methods
    func setViewsProperties() {
        karaokeView.titleLabel.text = contentName
        karaokeView.lyricsTextView.text = lyricsText
        karaokeView.backBtn.isEnabled = (index != 0)
        karaokeView.forwardBtn.isEnabled = (index != maxIndex)
    }
}
