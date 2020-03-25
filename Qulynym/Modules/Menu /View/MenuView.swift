/*
* Qulynym
* MenuView.swift
*
* Created by: Metah on 6/10/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MenuViewProtocol: class {
    var collectionView: UICollectionView { get }
    var closeBtn: UIButton { get }
    var settingsBtn: UIButton { get }
    var titleLabel: UILabel { get }
    var arrowImageView: UIImageView { get }
    var backgroundOfArrowIV: UIView { get }
    var blurArrowBackground: UIVisualEffectView { get }
    
    func setupLayout()
}

class MenuView: MenuViewProtocol {
    // MARK:- Properties
    lazy var collectionView: UICollectionView = {
        return configureImagesCollectionView(scroll: .horizontal, image: "menu", background: nil)
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var settingsBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "settings"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Qulynym"
        lbl.backgroundColor = .white
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 15
        lbl.setupContentLabel(size: view.frame.height * 0.1)
        lbl.numberOfLines = 1
        return lbl
    }()
    lazy var arrowImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "arrow"))
        iv.isHidden = true
        iv.layer.zPosition = 1
        return iv
    }()
    lazy var backgroundOfArrowIV: UIView = {
        let v = UIView()
        v.isHidden = true
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var blurArrowBackground: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundOfArrowIV.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true
        blurEffectView.layer.cornerRadius = backgroundOfArrowIV.frame.width * 0.5
        return blurEffectView
    }()
    private weak var view: UIView!
    
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(settingsBtn)
        view.addSubview(titleLabel)
        view.addSubview(arrowImageView)
        view.addSubview(backgroundOfArrowIV)
        setAutoresizingFalse()
        activateConstraints()
        closeBtn.configureCloseBtnFrame(view)
        backgroundOfArrowIV.addSubview(blurArrowBackground)
    }
    
    private func setAutoresizingFalse() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        let constant = view.frame.width * 0.01
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            settingsBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            settingsBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            settingsBtn.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.06),
            settingsBtn.widthAnchor.constraint(equalTo: settingsBtn.heightAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            arrowImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor),
            
            backgroundOfArrowIV.leadingAnchor.constraint(equalTo: arrowImageView.leadingAnchor),
            backgroundOfArrowIV.trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor),
            backgroundOfArrowIV.topAnchor.constraint(equalTo: arrowImageView.topAnchor),
            backgroundOfArrowIV.bottomAnchor.constraint(equalTo: arrowImageView.bottomAnchor),
        ])
    }
}
