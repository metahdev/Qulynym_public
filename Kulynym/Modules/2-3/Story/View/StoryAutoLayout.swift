/*
* Kulynym
* StoryAutoLayout.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol StoryAutoLayoutProtocol: class {
    var backgroundImage: UIImageView { get set }
    var characterImage: UIImageView { get set }
    var closeBtn: UIButton { get set } 
    
    func setupLayout()
}

class StoryAutoLayout: StoryAutoLayoutProtocol {
    // MARK:- Properties
    lazy var backgroundImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var characterImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = false
        return sv
    }()
    
    private var innerViews = [UIView]()
    private weak var view: UIView!
    
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setScrollViewSubviewsMask()
        activateMainConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(closeBtn)
        scrollView.addSubview(backgroundImage)
        scrollView.addSubview(characterImage)
    }
    
    private func setScrollViewSubviewsMask() {
        for subview in scrollView.subviews + view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateMainConstraints() {
        let constant = view.frame.height * 0.25
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor),
            closeBtn.widthAnchor.constraint(equalToConstant: constant + 24),
            closeBtn.heightAnchor.constraint(equalToConstant: constant),
        ])
    }
}
