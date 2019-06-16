/*
* Kulynym
* MessageAutoLayout.swift
*
* Created by: Metah on 6/6/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MessageAutoLayoutProtocol: class {
    var closeBtn: UIButton { get set }
    var emotionImage: UIImageView { get set }
    var titleLabel: UILabel { get set }
    
    func setupLayout()
}

class MessageAutoLayout: MessageAutoLayoutProtocol {
    // MARK:- Properties
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    lazy var emotionImage: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
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
        view.addSubview(emotionImage)
        view.addSubview(titleLabel)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            emotionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emotionImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emotionImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            emotionImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            closeBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: -4),
            closeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            closeBtn.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25, constant: 24),
            closeBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            ])
    }
}
