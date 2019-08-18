/*
* Kulynym
* PlaylistView.swift
*
* Created by: Metah on 5/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol PlaylistViewProtocol: class {
    var listCollectionView: UICollectionView { get set }
    var closeBtn: UIButton { get set }
    var titleLabel: UILabel { get set }
    
    func setupLayout()
}

class PlaylistView: PlaylistViewProtocol {
    // MARK:- Properties
    lazy var listCollectionView: UICollectionView = {
        return configureImagesCollectionView(scroll: .vertical, image: nil, background: nil)
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.setupContentLabel(size: view.frame.height * 0.1)
        return lbl
    }()
    private lazy var backgroundImage: UIImageView = {
        let imageV = UIImageView(image: UIImage(named: "playlistBg"))
        imageV.layer.zPosition = -1
        return imageV
    }()
    private weak var view: UIView!
    
    
    // MARK:- Initialization
    required init(view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        backgroundImage.configureBackgroundImagePosition(view)
        activateConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(listCollectionView)
        view.addSubview(closeBtn)
        view.addSubview(titleLabel)
        view.addSubview(backgroundImage)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        let constant = view.frame.height * 0.25 + 56
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: closeBtn.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(constant)),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            
            listCollectionView.topAnchor.constraint(equalTo: closeBtn.bottomAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
