/*
 * Kulynym
 * ItemVCAutoLayout.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class ItemVCAutoLayout {
    weak var view: UIView!
    weak var contentBtn: UIButton!
    weak var closeBtn: UIButton!
    weak var forwardBtn: UIButton!
    weak var background: UIImageView!
    var innerViews = [UIView]()
    var constraints = [NSLayoutConstraint]()
    
    required init(_ view: UIView, contentBtn: UIButton, closeBtn: UIButton, forwardBtn: UIButton, background: UIImageView) {
        self.view = view
        self.contentBtn = contentBtn
        self.closeBtn = closeBtn
        self.forwardBtn = forwardBtn
        self.background = background
        
        addViewsToInnerViewsArray()
        addInnerViewsToTheViewAndAutoresizingFalse()
        initConstraints()
        activateConstraints()
    }

    func addViewsToInnerViewsArray() {
        innerViews.append(contentBtn)
        innerViews.append(closeBtn)
        innerViews.append(forwardBtn)
        innerViews.append(background)
    }
    
    func addInnerViewsToTheViewAndAutoresizingFalse() {
        for innerView in innerViews {
            view.addSubview(innerView)
            innerView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func initConstraints() {
        let imageViewConstant = view.frame.height * 0.5
        let forwardBtnConstant = view.frame.height * 0.25
        
        constraints = [
            contentBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentBtn.widthAnchor.constraint(equalToConstant: imageViewConstant),
            contentBtn.heightAnchor.constraint(equalToConstant: imageViewConstant),
            
            forwardBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            forwardBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forwardBtn.heightAnchor.constraint(equalToConstant: forwardBtnConstant),
            forwardBtn.widthAnchor.constraint(equalToConstant: forwardBtnConstant + 24),
            
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor),
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeBtn.widthAnchor.constraint(equalToConstant: forwardBtnConstant + 24),
            closeBtn.heightAnchor.constraint(equalToConstant: forwardBtnConstant),
            
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate(constraints)
    }
    
    func deactivateConstraints() {
        NSLayoutConstraint.deactivate(constraints)
    }
}
