/*
 * Kulynym
 * ItemAutoLayout.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol ItemAutoLayoutProtocol: class {
    var contentBtn: UIButton { get set }
    var closeBtn: UIButton { get set }
    var forwardBtn: UIButton { get set }
    
    func setupLayout()
}

class ItemAutoLayout: ItemAutoLayoutProtocol {
    // MARK:- Properties
    lazy var contentBtn: UIButton = {
        let btn = UIButton()
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
        image.image = UIImage(named: "itemBackground")
        return image
    }()
    private weak var view: UIView!
    private var innerViews = [UIView]()

    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }

    
    // MARK:- Layout
    func setupLayout() {
        addViewsToInnerViews()
        addInnerViewsToTheViewAndMaskFalse()
        activateConstraints()
    }
    
    private func addViewsToInnerViews() {
        innerViews.append(contentBtn)
        innerViews.append(closeBtn)
        innerViews.append(forwardBtn)
        innerViews.append(backgroundImage)
    }
    
    private func addInnerViewsToTheViewAndMaskFalse() {
        for innerView in innerViews {
            view.addSubview(innerView)
            innerView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        let imageViewConstant = view.frame.height * 0.5
        let forwardBtnConstant = imageViewConstant * 0.5
        
        NSLayoutConstraint.activate([
            contentBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentBtn.widthAnchor.constraint(equalToConstant: imageViewConstant),
            contentBtn.heightAnchor.constraint(equalToConstant: imageViewConstant),
            
            forwardBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            forwardBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forwardBtn.heightAnchor.constraint(equalToConstant: forwardBtnConstant),
            forwardBtn.widthAnchor.constraint(equalToConstant: forwardBtnConstant + 24),
            
            closeBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeBtn.widthAnchor.constraint(equalToConstant: forwardBtnConstant + 24),
            closeBtn.heightAnchor.constraint(equalToConstant: forwardBtnConstant),
            
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
