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
    lazy var sectionTitleLabel = UILabel()
    
    var progress: Float! {
        didSet {
            NSLayoutConstraint.deactivate(tempConstraints)
            if progress != 0 {
                addProgressView()
                self.progressView.setProgress(progress, animated: true)
            } else {
                initCommonConstraints()
            }
            NSLayoutConstraint.activate(tempConstraints)
        }
    }
    
    #warning("add it when section is finished")
    private lazy var checkImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "checkTransparent")
        iv.backgroundColor = UIColor.green.withAlphaComponent(0.1)
        return iv
    }()
    private lazy var progressView: UIProgressView = {
        let pv = UIProgressView()
        pv.trackTintColor = .lightGray
        pv.progressTintColor = .green
        return pv
    }()
    private var tempConstraints = [NSLayoutConstraint]()
    
    
    // MARK:- Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(imageView)
        self.addSubview(sectionTitleLabel)
        setAutoresizingMaskToFalse()
        initCommonConstraints()
        NSLayoutConstraint.activate(tempConstraints)
        activateConstraints()
    }
    
    private func addProgressView() {
        self.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        initProgressViewConstraints()
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
    
    private func initCommonConstraints() {
        tempConstraints = [
            sectionTitleLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 16)
        ]
    }
    
    private func initProgressViewConstraints() {
        tempConstraints = [
            progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 16),
            
            sectionTitleLabel.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 8)
        ]
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -constant),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: constant),
            
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.sectionTitleLabel.text = ""
        self.imageView.image = nil
        self.progressView.removeFromSuperview()
        NSLayoutConstraint.deactivate(tempConstraints)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }
    
    
    // MARK: - Animations
    func flipCell(cardName: String, completion: @escaping () -> Void) {
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.imageView.image = UIImage(named: "backSide")
        }, completion: { _ in
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.imageView.image = UIImage(named: cardName)
            }, completion: { _ in
                completion()
            })
        })
        
    }
}
