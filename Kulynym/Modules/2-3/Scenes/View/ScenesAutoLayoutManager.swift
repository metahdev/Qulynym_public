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

protocol ScenesAutoLayoutProtocol: class {
    var sceneImageView: UIImageView { get set }
    var skipBtn: UIButton { get set }
    
    func setupLayout()
}

class ScenesAutoLayout: ScenesAutoLayoutProtocol {
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
    private var innerViews = [UIView]()
    
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addViewsToInnerViews()
        addInnerViewsToTheViewAndMaskFalse()
        activateConstraints()
    }
    
    private func addViewsToInnerViews() {
        innerViews.append(sceneImageView)
        innerViews.append(skipBtn)
    }
    
    private func addInnerViewsToTheViewAndMaskFalse() {
        for innerView in innerViews {
            innerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(innerView)
        }
    }
    
    private func activateConstraints() {
        let constant = view.frame.height * 0.25
        NSLayoutConstraint.activate([
            sceneImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneImageView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            skipBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            skipBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            skipBtn.widthAnchor.constraint(equalToConstant: constant + 40),
            skipBtn.heightAnchor.constraint(equalToConstant: constant)
        ])
    }
}
