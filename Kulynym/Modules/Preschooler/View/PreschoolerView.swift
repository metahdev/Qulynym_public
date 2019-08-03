/*
* Kulynym
* PreschoolerView.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

enum IconPosition {
    case up
    case down
    case begin
}

protocol PreschoolerViewProtocol {
    var closeBtn: UIButton { get set }
    
    func setupLayout()
}

class PreschoolerView: PreschoolerViewProtocol {
    // MARK:- Properties
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = false
        return sv
    }()
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "5-6bg")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private weak var view: UIView!
    private var constant: CGFloat!
    private var constraints = [NSLayoutConstraint]()
    
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    private func setupIconButton(image name: String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: name), for: .normal)
        return btn
    }
    
    func setupLayout() {
        addSubviews()
        makeSubviewsMaskFalse()
        closeBtn.configureCloseBtnFrame(view)
        activateConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(closeBtn)
        scrollView.addSubview(backgroundImageView)
    }
    
    private func makeSubviewsMaskFalse() {
        for subview in scrollView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        constant = view.frame.height * 0.5
        
        addScrollViewAndImageViewConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addScrollViewAndImageViewConstraints() {
        constraints += [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -64),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 64),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
    }
    
    private func addIconButtonConstraints(iconButton: UIButton, positionType: IconPosition, leftView: UIView) {
        
        constraints += [
            iconButton.heightAnchor.constraint(equalToConstant: constant),
            iconButton.widthAnchor.constraint(equalToConstant: constant),
        ]
        
        switch (positionType) {
        case .up:
            constraints += [
                iconButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
                iconButton.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 44)
            ]
        case .down:
            constraints += [
                iconButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
                iconButton.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 44)
            ]
        case .begin:
            constraints += [
                iconButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
                iconButton.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 44)
            ]
        }
    }
}
