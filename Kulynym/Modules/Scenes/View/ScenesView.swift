/*
* Kulynym
* ScenesView.swift
*
* Created by: Metah on 3/2/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation
import UIKit

protocol ScenesViewProtocol: class {
    var sceneImageView: UIImageView { get set }
    var skipBtn: UIButton { get set }
    
    func setupLayout()
}

class ScenesView: ScenesViewProtocol {
    // MARK:- Properties
    lazy var sceneImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    lazy var skipBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "forward"), for: .normal)
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
        setSubviewMask()
        activateConstraints()
        skipBtn.configureForwardBtnFrame(view)
    }
    
    private func addSubviews() {
        view.addSubview(sceneImageView)
        view.addSubview(skipBtn)
    }
    
    private func setSubviewMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            sceneImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneImageView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
