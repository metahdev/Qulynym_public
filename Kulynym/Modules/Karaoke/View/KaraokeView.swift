/*
* Kulynym
* KaraokeView.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import AVKit

protocol KaraokeViewProtocol: class {
    var closeBtn: UIButton { get }
    var playBtn: UIButton { get }
    var titleLabel: UILabel { get }
    var lyricsTextView: UITextView { get }
    var forwardBtn: UIButton { get }
    var backBtn: UIButton { get }
    
    func setupLayout()
}

class KaraokeView: KaraokeViewProtocol {
    // MARK:- Properties
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.layer.zPosition = 1
        return btn
    }()
    lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "playBtn"), for: .normal)
        return btn
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.setupContentLabel(size: view.frame.height * 0.1)
        return lbl
    }()
    lazy var forwardBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "nextVideoBtn"), for: .normal)
        return btn
    }()
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "backVideoBtn"), for: .normal)
        return btn
    }()
    lazy var lyricsTextView: UITextView = {
        let textV = UITextView()
        textV.layer.borderWidth = 5
        textV.layer.borderColor = UIColor.brown.cgColor
        textV.isEditable = false
        textV.isSelectable = false
        textV.isScrollEnabled = true
        return textV
    }()
    private lazy var storyBackgroundImage: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "karaokeBg"))
        imageV.layer.zPosition = -1
        return imageV
    }()
    private weak var view: UIView!
    
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        storyBackgroundImage.configureBackgroundImagePosition(view)
        activateMainConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(storyBackgroundImage)
        view.addSubview(closeBtn)
        view.addSubview(lyricsTextView)
        view.addSubview(titleLabel)
        view.addSubview(playBtn)
        view.addSubview(forwardBtn)
        view.addSubview(backBtn)
    }
    
    private func setSubviewsMask() {
        view.subviews.map({$0.translatesAutoresizingMaskIntoConstraints = false})
    }
    
    private func activateMainConstraints() {
        NSLayoutConstraint.activate([
            lyricsTextView.topAnchor.constraint(equalTo: view.topAnchor),
            lyricsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lyricsTextView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            lyricsTextView.heightAnchor.constraint(equalTo: lyricsTextView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: lyricsTextView.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            playBtn.widthAnchor.constraint(equalTo: lyricsTextView.widthAnchor, multiplier: 0.3),
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
