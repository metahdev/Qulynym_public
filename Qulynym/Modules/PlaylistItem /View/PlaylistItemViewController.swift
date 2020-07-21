 /*
* Qulynym
* PlaylistItemViewController.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
 */

import UIKit
import AVKit

protocol PlaylistItemViewControllerProtocol: class {
    var isKaraoke: Bool { get set }
    var contentName: String { get set }
    var lyricsText: [String] { get set }
    var index: Int { get set }
    var maxIndex: Int { get set }
    var isPlaying: Bool { get }
    
    func setViewsProperties()
    func setTimelineSliderMaxValue()
    func playBtnPressed()
    func setTimelineSliderValue(_ value: Float)
}

 class PlaylistItemViewController: UIViewController, PlaylistItemViewControllerProtocol {
    // MARK:- Properties
    var isKaraoke = true
    var contentName = ""
    var lyricsText: [String] = []
    var index = 0
    var maxIndex = 0
    var isPlaying = false
    var isOpenSlider = true
    var presenter: PlaylistItemPresenterProtocol!
    
    private var scrolledToEnd = false
    private let configurator: PLaylistItemConfiguratorProtocol = PlaylistItemConfigurator()
    private var playlistItemView: PlaylistItemViewProtocol!
    
    
    // MARK:- Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        initLayout()
        playlistItemView.setupLayout()
        assignActions()
        presenter.getLyricsText()
        presenter.getMaxCount()
        presenter.initTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playBtnPressed()
        setViewsProperties()
        configureBtnsEnability()
        AudioPlayer.backgroundAudioPlayer.stop()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        playlistItemView = PlaylistItemView(self.view, isKaraoke)
    }
    
    // MARK:- Actions
    private func assignActions() {
        playlistItemView.playBtn.addTarget(self, action: #selector(playBtnPressed), for: .touchUpInside)
        playlistItemView.backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        playlistItemView.forwardBtn.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        playlistItemView.closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
        playlistItemView.timelineSlider.addTarget(self, action: #selector(timelineSliderValueChanged), for: .valueChanged)
        playlistItemView.soundSlider.addTarget(self, action: #selector(soundSliderValueChanged), for: .valueChanged)
        playlistItemView.soundButton.addTarget(self, action: #selector(soundBtnPressed), for: .touchUpInside)

        let timelineSliderTap = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(gestureRecognizer:)))
        let soundSliderTap = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(gestureRecognizer:)))
        playlistItemView.timelineSlider.addGestureRecognizer(timelineSliderTap)
        playlistItemView.soundSlider.addGestureRecognizer(soundSliderTap)
    }
    
    @objc
    func sliderTapped(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.view == playlistItemView.timelineSlider {
            if gestureRecognizer.location(in: view).x < playlistItemView.timelineSlider.frame.width + playlistItemView.timelineSlider.frame.minX {
                self.sliderTappedActions(playlistItemView.timelineSlider, point: gestureRecognizer.location(in: view))
                self.timelineSliderValueChanged()
            }
        } else {
            sliderTappedActions(playlistItemView.soundSlider, point: gestureRecognizer.location(in: view))
            soundSliderValueChanged()
        }
    }
    
    private func sliderTappedActions(_ slider: UISlider, point position: CGPoint) {
        let positionOfSlider: CGPoint = slider.frame.origin
        let widthOfSlider: CGFloat = slider.frame.size.width
        let newValue = ((position.x - positionOfSlider.x) * CGFloat(slider.maximumValue) / widthOfSlider)
        slider.value = Float(newValue)
    }
    
    @objc
    func playBtnPressed() {
        if isPlaying {
            presenter.pauseAudio()
            playlistItemView.playBtn.setBackgroundImage(UIImage(named: "playBtn"), for: .normal)
        } else {
            presenter.playAudio()
            playlistItemView.playBtn.setBackgroundImage(UIImage(named: "pauseBtn"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc
    private func backBtnPressed() {
        presenter.backToPreviousAudio()
        playlistItemView.backBtn.isEnabled = false
        playlistItemView.forwardBtn.isEnabled = false
        playlistItemView.forwardBtn.alpha = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.configureBtnsEnability()
        })
    }
    
    @objc
    private func nextBtnPressed() {
        presenter.nextAudio()
        playlistItemView.backBtn.isEnabled = false
        playlistItemView.forwardBtn.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.configureBtnsEnability()
        })
    }
    
    @objc
    private func closeBtnPressed() {
        presenter.close()
    }
    
    private func configureBtnsEnability() {
        playlistItemView.backBtn.isEnabled = (index != 0)
        playlistItemView.forwardBtn.isEnabled = (index != maxIndex)
    }
    
    @objc
    private func timelineSliderValueChanged() {
        if !isPlaying {
            playBtnPressed()
        }
        presenter.scrollAudio(to: playlistItemView.timelineSlider.value)
    }
    
    @objc
    private func soundSliderValueChanged() {
        presenter.changeAudioVolume(to: playlistItemView.soundSlider.value)
        
        changeSoundBtnImage(playlistItemView.soundSlider.value)
    }
    
    private func changeSoundBtnImage(_ value: Float) {
        if value == 0.0 {
            playlistItemView.soundButton.setImage(UIImage(named: "soundsIconOff"), for: .normal)
            isOpenSlider = false
        } else {
            playlistItemView.soundButton.setImage(UIImage(named: "soundsIcon"), for: .normal)
            isOpenSlider = true
        }
    }
    
    @objc
    private func soundBtnPressed() {
        var value: Float
        
        if isOpenSlider {
            value = 0
        } else {
            value = 1
        }
        
        playlistItemView.soundSlider.setValue(value, animated: true)
        presenter.changeAudioVolume(to: value)
        changeSoundBtnImage(value)
    }
}


extension PlaylistItemViewController {
    // MARK:- Protocol Methods
    func setViewsProperties() {
        playlistItemView.titleLabel.text = contentName
        if isKaraoke {
//            playlistItemView.lyricsTextView.text = lyricsText
        } else {
            playlistItemView.storyImageView.image = UIImage(named: contentName)
        }
        playlistItemView.soundSlider.value = 1
        playlistItemView.soundButton.setImage(UIImage(named: "soundsIcon"), for: .normal)
        isOpenSlider = true
        playlistItemView.lyricsCV.delegate = self
        playlistItemView.lyricsCV.dataSource = self
    }

    
    func setTimelineSliderMaxValue() {
        playlistItemView.timelineSlider.maximumValue = Float(AudioPlayer.playlistItemAudioPlayer.duration)
    }
    
    func setTimelineSliderValue(_ value: Float) {
        playlistItemView.timelineSlider.value = value
        
        if value >= Float(presenter.duration) {
            presenter.timer.timerEnded()
            playlistItemView.timelineSlider.setValue(0, animated: true)
            playBtnPressed()
        }
    }
}
 
 extension PlaylistItemViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectionView Protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lyricsText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! TitleCollectionViewCell
        let lyricsLine = lyricsText[indexPath.row]
        cell.title = lyricsLine
        cell.widthConstant = collectionView.frame.width 
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lyricsLine = lyricsText[indexPath.row]
        return CGSize(width: collectionView.frame.width, height: lyricsLine.size(withAttributes: nil).height)
//        return lyricsLine.size(withAttributes: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

 }
