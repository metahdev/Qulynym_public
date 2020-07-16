/*
 * Qulynym
 * ItemView.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ItemViewProtocol: class {
    var titleLabel: UILabel { get }
    var contentBtn: UIButton { get }
    var closeBtn: UIButton { get }
    var forwardBtn: UIButton { get }
    
    func setupLayout()
}

class ItemView: ItemViewProtocol {
    // MARK:- Properties
    lazy var contentBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.imageView?.layer.cornerRadius = 5
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
        btn.contentVerticalAlignment = UIControl.ContentVerticalAlignment.fill
        btn.setupShadow()
        return btn
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.setupPlaylistLabel(size: view.frame.height * 0.1)
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 15
        return lbl
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var forwardBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "forward"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.layer.zPosition = -1
        image.image = UIImage(named: "itemBg")
        return image
    }()
    private weak var view: UIView!

    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }

    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewMask()
        activateConstraints()
        closeBtn.configureCloseBtnFrame(view)
        forwardBtn.configureForwardBtnFrame(view)
        backgroundImage.configureBackgroundImagePosition(view)
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(contentBtn)
        view.addSubview(closeBtn)
        view.addSubview(forwardBtn)
        view.addSubview(backgroundImage)
    }
    
    private func setSubviewMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentBtn.topAnchor, constant: -16),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            contentBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentBtn.widthAnchor.constraint(equalTo: view.heightAnchor),
            contentBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
}
