/*
* Kulynym
* MainMenuAutoLayoutManager.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

protocol MainMenuAutoLayoutProtocol {
    func configureLayout()
}

class MainMenuAutoLayout: MainMenuAutoLayoutProtocol {
    // MARK:- Properties
    weak var view: UIView!
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.bounces = false
        return sv
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "2-4bg")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var alphabetBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "alphabetIcon"), for: .normal)
        return btn
    }()
    
    lazy var numbersBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "numbersIcon"), for: .normal)
        return btn
    }()
    
    lazy var animalsBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "animalsIcon"), for: .normal)
        return btn
    }()
    
    
    // MARK:- Initialization
    required init(view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func configureLayout() {
        addSubviews()
        makeSubviewsMaskFalse()
        activateConstraints()
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundImageView)
        scrollView.addSubview(alphabetBtn)
        scrollView.addSubview(numbersBtn)
        scrollView.addSubview(animalsBtn)
    }
    
    func makeSubviewsMaskFalse() {
        for subview in scrollView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func activateConstraints() {
        let constant = view.frame.height * 0.5
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
        ])
    }
}
