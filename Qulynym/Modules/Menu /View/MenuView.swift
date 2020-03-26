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
    var containerView: UIView { get }
    var blurView: UIVisualEffectView { get }
    
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
    lazy var containerView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .clear
        return view
    }()
    lazy var arrowImageView: UIImageView = {
        let image = UIImage(named: "arrow")
        let iv = UIImageView(image: image)
        iv.isHidden = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.isHidden = true
        blurView.clipsToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
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
        view.addSubview(containerView)
        containerView.addSubview(blurView)
        containerView.addSubview(arrowImageView)
        setAutoresizingFalse()
        
        activateMainConstraints()
        constraintSubviewToFitSuperview(subview: collectionView, superview: view)
        constraintSubviewToFitSuperview(subview: arrowImageView, superview: containerView)
        constraintSubviewToFitSuperview(subview: blurView, superview: containerView)
        
        closeBtn.configureCloseBtnFrame(view)
    }
    
    private func setAutoresizingFalse() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateMainConstraints() {
        let constant = view.frame.width * 0.01
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            settingsBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            settingsBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            settingsBtn.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.06),
            settingsBtn.widthAnchor.constraint(equalTo: settingsBtn.heightAnchor),
            
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18),
            containerView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor),
        ])
    }
}
