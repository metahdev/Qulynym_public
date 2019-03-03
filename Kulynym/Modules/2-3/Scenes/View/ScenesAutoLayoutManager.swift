/*
* Kulynym
* ScenesAutoLayoutManager.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

class ScenesAutoLayoutManager {
    weak var view: UIView!
    weak var imageView: UIImageView!
    weak var skip: UIButton!
    var innerViews = [UIView]()
    var constraints = [NSLayoutConstraint]()
    
    required init(view: UIView, imageView: UIImageView, forwardBtn: UIButton) {
        self.view = view
        self.imageView = imageView
        self.skip = forwardBtn
        
        addViewsToSubviews()
        addInnerViewsToTheViewAndAutoresizingFalse()
        initConstraints()
        activateConstraints()
    }
    
    func addViewsToSubviews() {
        innerViews.append(imageView)
        innerViews.append(skip)
    }
    
    func addInnerViewsToTheViewAndAutoresizingFalse() {
        for innerView in innerViews {
            innerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(innerView)
        }
    }
    
    func initConstraints() {
        let constant = view.frame.height * 0.25
        constraints = [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            skip.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skip.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            skip.widthAnchor.constraint(equalToConstant: constant + 40),
            skip.heightAnchor.constraint(equalToConstant: constant),
        ]
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate(constraints)
    }
    
    func deactivateConstraints() {
        NSLayoutConstraint.deactivate(constraints)
    }
}
