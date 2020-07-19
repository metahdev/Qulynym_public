/*
 * Qulynym
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
        return configureImagesCollectionView(scroll: .vertical,/* image: nil,*/ background: nil)
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 15
        return lbl
    }()
    private lazy var backgroundIV: UIImageView = {
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
        setupTitleLabel(horizontalSizeClass: view.traitCollection.horizontalSizeClass)
        addSubviews()
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        backgroundIV.configureBackgroundImagePosition(view)
        activateConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(listCollectionView)
        view.addSubview(closeBtn)
        view.addSubview(titleLabel)
        view.addSubview(backgroundIV)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.54),
            
            listCollectionView.topAnchor.constraint(equalTo: closeBtn.bottomAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupTitleLabel(horizontalSizeClass: UIUserInterfaceSizeClass) {
        if horizontalSizeClass == .compact {
            titleLabel.setupPlaylistLabel(size: view.frame.height * 0.1)
        } else {
            titleLabel.setupPlaylistLabel(size: view.frame.height * 0.06)
        }
    }
}
