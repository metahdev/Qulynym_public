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
    var rightArrowView: UIView { get }
    var leftArrowView: UIView { get }
    
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
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 15
        lbl.setupMenuLabel(size: view.frame.height * 0.1)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var rightArrowView: UIView = {
        let v = ArrowView()
        v.layer.cornerRadius = view.frame.height * 0.06
        return v
    }()
    lazy var leftArrowView: UIView = {
        let v = ArrowView()
        v.transform = CGAffineTransform(rotationAngle: .pi)
        v.layer.cornerRadius = view.frame.height * 0.06
        return v
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
        view.addSubview(rightArrowView)
        view.addSubview(leftArrowView)
        setAutoresizingFalse()
        activateMainConstraints()
        constraintSubviewToFitSuperview(subview: collectionView, superview: view)
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
            
            settingsBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            settingsBtn.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.06),
            settingsBtn.widthAnchor.constraint(equalTo: settingsBtn.heightAnchor),
            settingsBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
            
            rightArrowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightArrowView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            rightArrowView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            rightArrowView.widthAnchor.constraint(equalTo: rightArrowView.heightAnchor),

            leftArrowView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            leftArrowView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftArrowView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            leftArrowView.widthAnchor.constraint(equalTo: leftArrowView.heightAnchor)
        ])
    }
}
