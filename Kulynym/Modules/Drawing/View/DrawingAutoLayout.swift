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
    lazy var drawingImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "flowerDrawing")
        return iv
    }()
    lazy var toolsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        
        cv.setCollectionViewLayout(layout, animated: true)
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "reuseID")
        return cv
    }()
    lazy var resetBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "reset"), for: .normal)
        return btn
    }()
    private weak var view: UIView!
    
    
    // MARK:- Initialization 
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
        view.addSubview(closeBtn)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            toolsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolsCollectionView.heightAnchor.constraint(equalTo: view.frame.height),
        ])
    }
}
