/*
* Kulynym
* StoryView.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol StoryViewProtocol: class {
    var closeBtn: UIButton { get set } 
    
    func setupLayout()
}

class StoryView: StoryViewProtocol {
    // MARK:- Properties
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.layer.zPosition = 1
        return btn
    }()
    private weak var view: UIView!
    
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        activateMainConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(closeBtn)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateMainConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
}
