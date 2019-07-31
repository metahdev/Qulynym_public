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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundView = UIImageView(image: UIImage(named: "itemBg"))
        
        cv.setCollectionViewLayout(layout, animated: true)
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "reuseID")
        return cv
    }()
    lazy var soundsButton: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "soundsIcon"), for: .normal)
        return btn
    }()
    lazy var closeBtn: UIButton = {
        var btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    private weak var view: UIView!
    
    
    // MARK:- Inititalization
    required init(_ view: UIView) {
        self.view = view
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
            soundsButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            soundsButton.heightAnchor.constraint(equalTo: soundsButton.heightAnchor),
            
            cardsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            cardsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
