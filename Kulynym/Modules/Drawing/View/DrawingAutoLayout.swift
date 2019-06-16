//
/*
* Kulynym
* DrawingAutoLayout.swift
*
* Created by: Metah on 5/30/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol DrawingAutoLayoutProtocol: class {
    var closeBtn: UIButton { get set }
    
    func setupLayout()
}

class DrawingAutoLayout: DrawingAutoLayoutProtocol {
    // MARK:- Properties
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
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
        activateConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(closeBtn)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        let constant = view.frame.height * 0.25
        NSLayoutConstraint.activate([
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor),
            closeBtn.widthAnchor.constraint(equalToConstant: constant + 24),
            closeBtn.heightAnchor.constraint(equalToConstant: constant),
        ])
    }
}
