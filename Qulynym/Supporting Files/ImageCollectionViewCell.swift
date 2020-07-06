/*
* Qulynym
* ImageCollectionViewCell.swift
*
* Created by: Metah on 6/11/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    // MARK:- Properties
    var beine: Beine? {
        didSet {
            sectionTitleLabel.text = beine?.title
            setupThumbnailImage()
        }
    }
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var text: String! {
        didSet {
            sectionTitleLabel.text = text
        }
    }
    
    var constant: CGFloat = 0
    weak var warningCaller: ConnectionWarningCaller!
    lazy var imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        return iv
    }()
    lazy var sectionTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.layer.cornerRadius = 15
        return lbl
    }()
    
    // MARK:- Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(imageView)
        self.addSubview(sectionTitleLabel)
        setAutoresizingMaskToFalse()
        activateConstraints()
    }
    
    
    // MARK:- Methods    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = beine?.thumbnailURL {
            imageView.loadImageUsingUrlString(urlString: thumbnailImageUrl, warningCaller: self.warningCaller)
        }
    }
    
    
    // MARK:- Layout
    private func setAutoresizingMaskToFalse() {
        _ = self.subviews.map{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -constant),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: constant),
            
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sectionTitleLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 16)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.sectionTitleLabel.text = ""
        self.imageView.image = nil
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }
}
