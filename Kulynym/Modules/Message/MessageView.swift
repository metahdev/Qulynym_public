
/*
* Kulynym
* MessageView.swift
*
* Created by: Metah on 6/6/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol MessageViewProtocol: class {
    var closeBtn: UIButton { get set }
    var emotionImage: UIImageView { get set }
    var firstInstructionImage: UIImageView { get set }
    var secondInstructionImage: UIImageView { get set }
    
    func setupLayout()
}

class MessageView: MessageViewProtocol {
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
    lazy var firstInstructionImage: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    lazy var secondInstructionImage: UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    private lazy var alertBackground: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "alertBg")
        imageV.layer.zPosition = -1
        return imageV
    }()
    private weak var view: UIView!
    
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
        self.view.backgroundColor = .clear
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        activateConstraints()
        alertBackground.configureBackgroundImagePosition(view)
    }
    
    private func addSubviews() {
        view.addSubview(closeBtn)
        view.addSubview(emotionImage)
        view.addSubview(firstInstructionImage)
        view.addSubview(secondInstructionImage)
        view.addSubview(alertBackground)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            emotionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emotionImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emotionImage.topAnchor.constraint(equalTo: view.topAnchor, constant: closeBtn.frame.height),
            emotionImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            
            secondInstructionImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondInstructionImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            secondInstructionImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            secondInstructionImage.widthAnchor.constraint(equalTo: secondInstructionImage.heightAnchor),
            
            firstInstructionImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstInstructionImage.bottomAnchor.constraint(equalTo: secondInstructionImage.topAnchor),
            firstInstructionImage.heightAnchor.constraint(equalTo: secondInstructionImage.heightAnchor),
            firstInstructionImage.widthAnchor.constraint(equalTo: firstInstructionImage.heightAnchor)
        ])
    }
}
