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
    var rightContainerView: UIView { get }
    var leftContainerView: UIView { get }
    
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
    lazy var rightContainerView: UIView = {
        let v = ContainerView(superview: view)
        return v.setView
    }()
    lazy var leftContainerView: UIView = {
        let v = ContainerView(superview: view)
        v.setView.transform = CGAffineTransform(rotationAngle: .pi)
        return v.setView
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
        view.addSubview(rightContainerView)
        view.addSubview(leftContainerView)
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
            
            settingsBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            settingsBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            settingsBtn.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.06),
            settingsBtn.widthAnchor.constraint(equalTo: settingsBtn.heightAnchor),
            
            rightContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            rightContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            rightContainerView.widthAnchor.constraint(equalTo: rightContainerView.heightAnchor),

            leftContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            leftContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            leftContainerView.widthAnchor.constraint(equalTo: leftContainerView.heightAnchor)
        ])
    }
}
