//
/*
* Kulynym
* ImageCollectionViewCell.swift
*
* Created by: Metah on 6/11/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    // MARK:- Properties
    var imageName: String! {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true 
        return iv
    }()
    
    // MARK:- Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    // MARK:- Layout
    private func setupLayout() {
        self.addSubview(imageView)
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
