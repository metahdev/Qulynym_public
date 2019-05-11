/*
* Kulynym
* MainMenuAutoLayout.swift
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
    case alphabet
}

protocol MainMenuAutoLayoutProtocol {
    var alphabetBtn: UIButton  { get set }
    var numbersBtn: UIButton { get set }
    var animalsBtn: UIButton { get set }
    var plantsBtn: UIButton { get set }
    var karaokeBtn: UIButton { get set }
    var storyTalesBtn: UIButton { get set }
    var drawingBtn: UIButton { get set }
    
    func setupLayout()
}

class MainMenuAutoLayout: MainMenuAutoLayoutProtocol {
    // MARK:- Properties
    lazy var alphabetBtn: UIButton = {
        let btn = setupIconButton(image: "alphabetIcon")
        return btn
    }()
    lazy var numbersBtn: UIButton = {
        let btn = setupIconButton(image: "numbersIcon")
        return btn
    }()
    lazy var animalsBtn: UIButton = {
        let btn = setupIconButton(image: "animalsIcon")
        return btn
    }()
    lazy var plantsBtn: UIButton = {
        let btn = setupIconButton(image: "plantsIcon")
        return btn
    }()
    lazy var karaokeBtn: UIButton = {
        let btn = setupIconButton(image: "karaokeIcon")
        return btn
    }()
    lazy var storyTalesBtn: UIButton = {
        let btn = setupIconButton(image: "storyTalesIcon")
        return btn
    }()
    lazy var drawingBtn: UIButton = {
        let btn = setupIconButton(image: "drawingIcon")
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
        iv.image = UIImage(named: "2-4bg")
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
        activateConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundImageView)
        scrollView.addSubview(alphabetBtn)
        scrollView.addSubview(numbersBtn)
        scrollView.addSubview(animalsBtn)
        scrollView.addSubview(plantsBtn)
        scrollView.addSubview(karaokeBtn)
        scrollView.addSubview(storyTalesBtn)
        scrollView.addSubview(drawingBtn)
    }
    
    private func makeSubviewsMaskFalse() {
        for subview in scrollView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        constant = view.frame.height * 0.5
        
        addScrollViewAndImageViewConstraints()
        addIconButtonConstraints(iconButton: alphabetBtn, positionType: .alphabet, leftView: scrollView)
        addIconButtonConstraints(iconButton: numbersBtn, positionType: .up, leftView: alphabetBtn)
        addIconButtonConstraints(iconButton: animalsBtn, positionType: .down, leftView: numbersBtn)
        addIconButtonConstraints(iconButton: plantsBtn, positionType: .up, leftView: animalsBtn)
        addIconButtonConstraints(iconButton: karaokeBtn, positionType: .down, leftView: plantsBtn)
        addIconButtonConstraints(iconButton: storyTalesBtn, positionType: .up, leftView: karaokeBtn)
        addIconButtonConstraints(iconButton: drawingBtn, positionType: .down, leftView: storyTalesBtn)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addScrollViewAndImageViewConstraints() {
        constraints += [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        case .alphabet:
            constraints += [
                iconButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
                iconButton.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 44)
            ]
        }
    }
}
