/*
 * Kulynym
 * ItemView.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ItemViewProtocol: class {
    var contentBtn: UIButton { get set }
    var closeBtn: UIButton { get set }
    var forwardBtn: UIButton { get set }
    
    func setupLayout()
}

class ItemView: ItemViewProtocol {
    // MARK:- Properties
    lazy var contentBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 5
        btn.imageView?.layer.cornerRadius = 5
        btn.layer.borderColor = UIColor.white.cgColor
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
        btn.contentVerticalAlignment = UIControl.ContentVerticalAlignment.fill
        return btn
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    lazy var forwardBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "forward"), for: .normal)
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
    }
    
    private func addSubviews() {
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
            contentBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentBtn.widthAnchor.constraint(equalTo: view.heightAnchor),
            contentBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
