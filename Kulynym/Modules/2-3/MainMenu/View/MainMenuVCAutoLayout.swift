/*
* Kulynym
* MainMenuVCAutoLayoutManager.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

class MainMenuVCAutoLayout {
    weak var view: UIView!
    weak var scrollView: UIScrollView!
    weak var background: UIImageView!
    weak var alphabetBtn: UIButton!
    weak var numbersBtn: UIButton!
    weak var animalsBtn: UIButton!
    var constraints = [NSLayoutConstraint]()
    
    required init(view: UIView, scrollView: UIScrollView, background: UIImageView, alphabetBtn: UIButton, numberBtn: UIButton, animalsBtn: UIButton) {
        self.view = view
        self.scrollView = scrollView
        self.background = background
        self.alphabetBtn = alphabetBtn
        self.numbersBtn = numberBtn
        self.animalsBtn = animalsBtn
        
        addViewsToSubviews()
        addInnerViewsToTheViewAndAutoresizingFalse()
        initConstraints()
        activateConstraints()
    }
    
    func addViewsToSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(background)
        scrollView.addSubview(self.alphabetBtn)
        scrollView.addSubview(self.numbersBtn)
        scrollView.addSubview(self.animalsBtn)
    }
    
    func addInnerViewsToTheViewAndAutoresizingFalse() {
        for subview in scrollView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func initConstraints() {
        let constant = view.frame.height * 0.5
        constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            background.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            background.topAnchor.constraint(equalTo: scrollView.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            alphabetBtn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 44),
            alphabetBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            alphabetBtn.heightAnchor.constraint(equalToConstant: constant),
            alphabetBtn.widthAnchor.constraint(equalToConstant: constant),
            
            numbersBtn.leadingAnchor.constraint(equalTo: alphabetBtn.trailingAnchor, constant: 44),
            numbersBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            numbersBtn.heightAnchor.constraint(equalToConstant: constant),
            numbersBtn.widthAnchor.constraint(equalToConstant: constant),
            
            animalsBtn.leadingAnchor.constraint(equalTo: numbersBtn.trailingAnchor, constant: 44),
            animalsBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            animalsBtn.heightAnchor.constraint(equalToConstant: constant),
            animalsBtn.widthAnchor.constraint(equalToConstant: constant),
        ]
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate(constraints)
    }
    
    func deactivateConstraints() {
        NSLayoutConstraint.deactivate(constraints)
    }
}
