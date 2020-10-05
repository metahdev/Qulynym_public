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
    var currentLine: Int { get set }
    var began: Bool { get set }
    var highlighting: Bool { get set }
    
    func setViewsProperties()
    func setTimelineSliderMaxValue()
    func playBtnPressed()
    func setTimelineSliderValue(_ value: Float)
    func scrollToCurrentLine()
    func updateCurrentLine()
    func clearLine()
}

 
 class PlaylistItemViewController: QulynymVC, PlaylistItemViewControllerProtocol {
    // MARK:- Properties
    var isKaraoke = true
    var contentName = ""
    var lyricsText: [String] = []
    var index = 0
    var maxIndex = 0
    var isPlaying = false
    var currentLine = 0
    var began = false
    var highlighting = true
    var isOpenSlider = true
    var presenter: PlaylistItemPresenterProtocol!
    
    private var scrolledToEnd = false
    private var timer = Timer()
    private var shouldScroll = true
    
    lazy var constant = playlistItemView.lyricsCV.frame.width - 40
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
        setupAppearence()
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
        initTimer() 
    }
    
    
    // MARK:- Appearence
    private func initLayout() {
        playlistItemView = PlaylistItemView(self.view, isKaraoke)
    }
    
    private func setupAppearence() {
        if !isKaraoke {
            playlistItemView.titleLabel.textColor = .lightViolet
            playlistItemView.soundSlider.tintColor = .lightViolet
            playlistItemView.timelineSlider.tintColor = .lightViolet
            playlistItemView.forwardBtn.setBackgroundImage(UIImage(named: "lightForward"), for: .normal)
            playlistItemView.backBtn.setBackgroundImage(UIImage(named: "lightBack"), for: .normal)
            playlistItemView.playBtn.setBackgroundImage(UIImage(named: "lightPause"), for: .normal)
        }
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
            let imageName = isKaraoke ? "darkPlay" : "lightPlay"
            playlistItemView.playBtn.setBackgroundImage(UIImage(named: imageName), for: .normal)
        } else {
            presenter.playAudio()
            let imageName = isKaraoke ? "darkPause" : "lightPause"
            playlistItemView.playBtn.setBackgroundImage(UIImage(named: imageName), for: .normal)
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
        var value = playlistItemView.timelineSlider.value
        value.roundToDecimals()
        presenter.scrollAudio(to: value)
    }
    
    @objc
    private func soundSliderValueChanged() {
        presenter.changeAudioVolume(to: playlistItemView.soundSlider.value)
        
        changeSoundBtnImage(playlistItemView.soundSlider.value)
    }
    
    private func changeSoundBtnImage(_ value: Float) {
        if value == 0.0 {
            playlistItemView.soundButton.setBackgroundImage(UIImage(named: "soundOff"), for: .normal)
            isOpenSlider = false
        } else {
            playlistItemView.soundButton.setBackgroundImage(UIImage(named: "soundOn"), for: .normal)
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
            playlistItemView.lyricsCV.reloadData()
        } else {
            playlistItemView.storyImageView.image = UIImage(named: contentName)
        }
        playlistItemView.soundSlider.value = 1
        currentLine = 0 
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
    
    
    // MARK:- Karaoke
    func scrollToCurrentLine() {
        if shouldScroll {
            playlistItemView.lyricsCV.scrollToItem(at: IndexPath(row: currentLine, section: 0), at: .centeredVertically, animated: true)

        }
    }

    func clearLine() {
        updateCellState(isCurrent: false)
    }

    func updateCurrentLine() {
        updateCellState(isCurrent: true)
    }
    
    private func updateCellState(isCurrent: Bool) {
        let cell = playlistItemView.lyricsCV.cellForItem(at: IndexPath(row: currentLine, section: 0)) as? TitleCollectionViewCell
        cell?.current = isCurrent
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
        cell.fontSize = constant * 0.1
        cell.setNeedsLayout()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard began else { return }
        let current = (currentLine == indexPath.row)
        (cell as! TitleCollectionViewCell).current = current && highlighting
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let attributeString = NSAttributedString(string: lyricsText[indexPath.row], attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: constant * 0.1)])
        let height = attributeString.height(containerWidth: collectionView.frame.width - 40)
        return CGSize(width: constant, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 12, bottom: 20, right: 12)
    }
    
    // MARK:- Timer
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.shouldScroll = false
        stopTimer()
        initTimer()
    }
    
    private func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(enableAutoscroll), userInfo: nil, repeats: false)
    }
    
    private func stopTimer() {
        timer.invalidate()
    }
    
    @objc
    private func enableAutoscroll() {
        shouldScroll = true
    }
 }
