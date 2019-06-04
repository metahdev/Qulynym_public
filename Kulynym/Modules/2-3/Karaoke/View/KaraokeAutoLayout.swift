/*
* Kulynym
* KaraokeAutoLayout.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol KaraokeAutoLayoutProtocol: class {
    var gramophoneImage: UIImageView { get set }
    var contentImage: UIImageView { get set }
    var videoView: UIView { get set }
    var closeBtn: UIButton { get set }
    
    func setupLayout()
    func initNoteView()
}

class KaraokeAutoLayout: KaraokeAutoLayoutProtocol {
    // MARK:- Properties
    weak var view: UIView!
    
    lazy var gramophoneImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var contentImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var videoView: UIView = {
        let v = UIView()
        return v
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    
    private lazy var charactersImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    private var innerViews = [UIView]()
    
    private var noteClipView: UIView!
    private var noteView: NoteView!
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        appendViewsToInnerViews()
        setAutoresizingAndAddToView()
        activateConstraints()
    }
    
    
    private func appendViewsToInnerViews() {
        innerViews.append(gramophoneImage)
        innerViews.append(contentImage)
        innerViews.append(charactersImage)
        innerViews.append(closeBtn)
        innerViews.append(videoView)
    }
    
    private func setAutoresizingAndAddToView() {
        for innerView in innerViews {
            view.addSubview(innerView)
            innerView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        let constant = view.frame.height * 0.5
        let btnConstant = constant * 0.5
        NSLayoutConstraint.activate([
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor),
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeBtn.widthAnchor.constraint(equalToConstant: btnConstant + 24),
            closeBtn.heightAnchor.constraint(equalToConstant: btnConstant),
            
            charactersImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            charactersImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersImage.topAnchor.constraint(equalTo: closeBtn.bottomAnchor, constant: 16),
            charactersImage.trailingAnchor.constraint(equalTo: closeBtn.trailingAnchor),
            
            contentImage.topAnchor.constraint(equalTo: view.topAnchor),
            contentImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentImage.heightAnchor.constraint(equalToConstant: btnConstant),
            contentImage.leadingAnchor.constraint(equalTo: closeBtn.trailingAnchor, constant: 20),
            
            videoView.leadingAnchor.constraint(equalTo: charactersImage.trailingAnchor, constant: 20),
            videoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            videoView.heightAnchor.constraint(equalToConstant: charactersImage.frame.height),
            videoView.widthAnchor.constraint(equalToConstant: contentImage.frame.width * 0.5),
            
            gramophoneImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 44),
            gramophoneImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            gramophoneImage.leadingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: 24),
            gramophoneImage.heightAnchor.constraint(equalToConstant: constant - 20)
        ])
    }
    
    
    // MARK:- Animation
    func initNoteView() {
        noteClipView.addSubview(noteView)
        view.addSubview(noteClipView)
    }
    
    private func initFrames() {
        let frame = CGRect(x: gramophoneImage.frame.origin.x, y: gramophoneImage.frame.origin.y * 0.5, width: gramophoneImage.frame.width, height: gramophoneImage.frame.height - 24)
    
        noteClipView = UIView(frame: frame)
        noteClipView.clipsToBounds = true
        noteView = NoteView(frame: frame)
    }
}
