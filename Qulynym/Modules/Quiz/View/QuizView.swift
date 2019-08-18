/*
* Kulynym
* QuizView.swift
*
* Created by: Metah on 7/31/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol QuizViewProtocol: class {
    var cardsCollectionView: UICollectionView { get set }
    var closeBtn: UIButton { get set }
    var soundsButton: UIButton { get set }
    
    func setupLayout()
}

class QuizView: QuizViewProtocol {
    // MARK:- Properties
    lazy var cardsCollectionView: UICollectionView = {
        return configureImagesCollectionView(scroll: .vertical, image: "itemBg", background: nil)
    }()
    lazy var soundsButton: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "soundsIcon"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    lazy var closeBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    private weak var view: UIView!
    
    
    // MARK:- Inititalization
    required init(_ view: UIView) {
        self.view = view
        view.backgroundColor = .white
    }
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        activateConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(cardsCollectionView)
        view.addSubview(closeBtn)
        view.addSubview(soundsButton)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    // MARK:- Constraints
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            soundsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soundsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            soundsButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            soundsButton.heightAnchor.constraint(equalTo: soundsButton.heightAnchor),
            
            cardsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            cardsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
