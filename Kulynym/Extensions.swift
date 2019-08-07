/*
* Kulynym
* Extensions.swift
*
* Created by: Metah on 3/3/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

// UIButton Constraints
extension UIButton {
    func configureCloseBtnFrame(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25, constant: 24),
            self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
        ])
    }
    
    func configureForwardBtnFrame(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25, constant: 40),
            self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
    }
}


// MARK:- UILabel properties
extension UILabel {
    func setupContentLabel(size: CGFloat) {
        self.font = UIFont(name: "Arial Rounded MT Bold", size: size)
        self.textColor = UIColor(red: 97/255, green: 104/255, blue: 189/255, alpha: 1)
        self.textAlignment = .center
    }
}


// MARK:- UIImageView constraints
extension UIImageView {
    func configureBackgroundImagePosition(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


// MARK:- UICollectionView
enum BackgroundType {
    case white
    case clear
}

func configureImagesCollectionView(scroll direction: UICollectionView.ScrollDirection, image name: String?, background type: BackgroundType?) -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = direction
    
    let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    
    if let imageName = name {
        cv.backgroundView = UIImageView(image: UIImage(named: imageName))
    }
    if type == .white {
        cv.backgroundColor = .white
    } else {
        cv.backgroundColor = .clear
    }
    
    cv.setCollectionViewLayout(layout, animated: true)
    cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "reuseID")
    
    cv.allowsMultipleSelection = false
    return cv
}


// MARK:- Audio
func callSwishAudioEffect() {
    AudioPlayer.setupExtraAudio(with: "swish", audioPlayer: .effects)
}

func callQuitAudioEffect() {
    AudioPlayer.setupExtraAudio(with: "quit", audioPlayer: .effects)
}
