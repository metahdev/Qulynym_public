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
    var isKaraoke: Bool { get set }
    var contentName: String { get set }
    var lyricsText: String { get set }
    var index: Int { get set }
    var maxIndex: Int { get set }
    var isPlaying: Bool { get }
    
    func setViewsProperties()
    func playBtnPressed()
    func changeSliderValue(_ value: Int)
}

class KaraokeViewController: UIViewController, KaraokeViewControllerProtocol {
    // MARK:- Properties
    var isKaraoke = true
    var contentName = ""
    var lyricsText = ""
    var index = 0
    var maxIndex = 0
    var isPlaying = false
    var isOpenSlider = true
    var presenter: KaraokePresenterProtocol!
    
    private var previouslyNotSetSoundsImage = true
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
        presenter.initTimer() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playBtnPressed()
        setViewsProperties()
        AudioPlayer.backgroundAudioPlayer.stop()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        karaokeView = KaraokeView(self.view, isKaraoke)
    }
    
    // MARK:- Actions
    private func assignActions() {
        karaokeView.playBtn.addTarget(self, action: #selector(playBtnPressed), for: .touchUpInside)
        karaokeView.backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        karaokeView.forwardBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        karaokeView.closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        karaokeView.timelineSlider.addTarget(self, action: #selector(timelineSliderValueChanged(_:)), for: .valueChanged)
        karaokeView.soundSlider.addTarget(self, action: #selector(soundSliderValueChanged), for: .valueChanged)
        karaokeView.soundButton.addTarget(self, action: #selector(soundBtnPressed), for: .touchUpInside)
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
    private func timelineSliderValueChanged(_ sender: UISlider) {
        presenter.scrollAudio(to: sender.value)
    }
    
    @objc
    private func soundSliderValueChanged(_ sender: UISlider) {
        presenter.changeAudioVolume(to: sender.value)
        
        changeSoundBtnImage(sender.value)
    }
    
    private func changeSoundBtnImage(_ value: Float) {
        if value == 0.0 {
            karaokeView.soundButton.setImage(UIImage(named: "soundsIconOff"), for: .normal)
            previouslyNotSetSoundsImage = true
        }
        if previouslyNotSetSoundsImage && value > 0.0 {
            karaokeView.soundButton.setImage(UIImage(named: "soundsIcon"), for: .normal)
            previouslyNotSetSoundsImage = false
        }
    }
    
    @objc
    private func soundBtnPressed() {
        var value: Float
        
        if isOpenSlider {
            value = 0
        } else {
            value = 100
        }
        
        karaokeView.soundSlider.setValue(value, animated: true)
        presenter.changeAudioVolume(to: value)
        changeSoundBtnImage(value)
        
        isOpenSlider = !isOpenSlider
//        karaokeView.changeSoundSliderView(isOpenSlider)
    }
}


extension KaraokeViewController {
    // MARK:- Protocol Methods
    func setViewsProperties() {
        karaokeView.titleLabel.text = contentName
        if isKaraoke {
            karaokeView.lyricsTextView.text = lyricsText
        } else {
            karaokeView.storyImageView.image = UIImage(named: contentName)
        }
        karaokeView.backBtn.isEnabled = (index != 0)
        karaokeView.forwardBtn.isEnabled = (index != maxIndex)
        karaokeView.timelineSlider.maximumValue = Float(AudioPlayer.karaokeAudioPlayer.duration)
    }
    
    func changeSliderValue(_ value: Int) {
        karaokeView.timelineSlider.value = Float(value)
        
        if value == 100 {
            presenter.scrollAudio(to: 0.0)
        }
    }
}
