 /*
* Qulynym
* PlaylistItemView.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
 */

import UIKit
import AVKit

protocol PlaylistItemViewProtocol: class {
    var closeBtn: UIButton { get }
    var playBtn: UIButton { get }
    var titleLabel: UILabel { get }
    var storyImageView: UIImageView { get }
    var lyricsCV: UICollectionView { get }
    var forwardBtn: UIButton { get }
    var backBtn: UIButton { get }
    var timelineSlider: UISlider { get }
    var soundButton: UIButton { get }
    var soundSlider: UISlider { get }
    
    func setupLayout()
}

class PlaylistItemView: PlaylistItemViewProtocol {
    // MARK:- Properties
    // i don't remember the reason why i rejected this idea? I think the emitterView blocked textView interaction(check it)
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.layer.zPosition = 1
        btn.setupShadow()
        return btn
    }()
    lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "darkPlay"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.setupPlaylistLabel(size: view.frame.height * 0.1)
        lbl.shadowColor = .clear
        lbl.backgroundColor = .clear
        return lbl
    }()
    lazy var forwardBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "darkForward"), for: .normal)
        return btn
    }()
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "darkBack"), for: .normal)
        return btn
    }()
    lazy var storyImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.layer.borderWidth = 5
        imageV.layer.borderColor = UIColor.brown.cgColor
        imageV.isHidden = true
        imageV.setupShadow()
        return imageV
    }()
    lazy var lyricsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        cv.layer.borderColor = UIColor.brown.cgColor
        cv.layer.borderWidth = 4
        cv.register(TitleCollectionViewCell.self , forCellWithReuseIdentifier: "reuseID")
        return cv
    }()
    lazy var timelineSlider: UISlider = {
        return setupPlaylistSlider(value: 0, secondColor: .gray)
    }()
    lazy var soundButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "soundOn"), for: .normal)
        return btn
    }()
    lazy var soundSlider: UISlider = {
        return setupPlaylistSlider(value: 1, secondColor: .red)
    }()
    private lazy var storyBackgroundImage: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "karaokeBg"))
        imageV.layer.zPosition = -1
        return imageV
    }()
    
    private var isKaraoke: Bool
    private weak var view: UIView!
    
    
    // MARK:- Initialization
    required init(_ view: UIView, _ isKaraoke: Bool) {
        self.view = view
        self.isKaraoke = isKaraoke
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        storyBackgroundImage.configureBackgroundImagePosition(view)
        setupChangingLayout()
        activateMainConstraints()
        soundSlider.transform = CGAffineTransform(rotationAngle: -.pi / 2)
    }
    
    private func addSubviews() {
        view.addSubview(storyBackgroundImage)
        view.addSubview(closeBtn)
        view.addSubview(lyricsCV)
        view.addSubview(storyImageView)
        view.addSubview(titleLabel)
        view.addSubview(playBtn)
        view.addSubview(forwardBtn)
        view.addSubview(backBtn)
        view.addSubview(timelineSlider)
        view.addSubview(soundSlider)
        view.addSubview(soundButton)
    }
    
    private func setSubviewsMask() {
        _ = view.subviews.map({$0.translatesAutoresizingMaskIntoConstraints = false})
    }
    
    private func setupChangingLayout() {
        if isKaraoke {
            storyBackgroundImage.image = UIImage(named: "karaokeBg")
        } else {
            storyBackgroundImage.image = UIImage(named: "storyBg")
        }
        storyImageView.isHidden = isKaraoke
        lyricsCV.isHidden = !isKaraoke
    }
    
    private func activateMainConstraints() {
        NSLayoutConstraint.activate([
            lyricsCV.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            lyricsCV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lyricsCV.widthAnchor.constraint(equalTo: view.heightAnchor),
            lyricsCV.heightAnchor.constraint(equalTo: lyricsCV.widthAnchor, multiplier: 0.5),
            
            storyImageView.topAnchor.constraint(equalTo: view.topAnchor),
            storyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            storyImageView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            storyImageView.heightAnchor.constraint(equalTo: storyImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: lyricsCV.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timelineSlider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            timelineSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timelineSlider.widthAnchor.constraint(equalTo: lyricsCV.widthAnchor),
            
            soundButton.leadingAnchor.constraint(equalTo: timelineSlider.trailingAnchor, constant: 16),
            soundButton.centerYAnchor.constraint(equalTo: timelineSlider.centerYAnchor),
            soundButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            soundButton.heightAnchor.constraint(equalTo: soundButton.widthAnchor),
            
            soundSlider.bottomAnchor.constraint(equalTo: soundButton.topAnchor, constant: -12),
            soundSlider.centerXAnchor.constraint(equalTo: soundButton.centerXAnchor),
            soundSlider.widthAnchor.constraint(equalTo: timelineSlider.widthAnchor, multiplier: 0.15),
            
            playBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playBtn.topAnchor.constraint(equalTo: timelineSlider.topAnchor, constant: 50),
            playBtn.widthAnchor.constraint(equalTo: lyricsCV.widthAnchor, multiplier: 0.1),
            playBtn.heightAnchor.constraint(equalTo: playBtn.widthAnchor),
            
            forwardBtn.leadingAnchor.constraint(equalTo: playBtn.trailingAnchor, constant: 8),
            forwardBtn.heightAnchor.constraint(equalTo: playBtn.heightAnchor),
            forwardBtn.widthAnchor.constraint(equalTo: forwardBtn.heightAnchor),
            forwardBtn.bottomAnchor.constraint(equalTo: playBtn.bottomAnchor),
            
            backBtn.trailingAnchor.constraint(equalTo: playBtn.leadingAnchor, constant: -8),
            backBtn.heightAnchor.constraint(equalTo: playBtn.heightAnchor),
            backBtn.widthAnchor.constraint(equalTo: backBtn.heightAnchor),
            backBtn.bottomAnchor.constraint(equalTo: playBtn.bottomAnchor),
        ])
    }
}

