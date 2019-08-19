/*
* Qulynym
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
        self.shadowColor = .black
        self.numberOfLines = 2
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
    
    cv.setCollectionViewLayout(layout, animated: false)
    cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "reuseID")
    
    cv.allowsMultipleSelection = false
    return cv
}

extension UIColor {
    static let skyColor = UIColor(red: 141/255, green: 232/255, blue: 237/255, alpha: 1)
}

// MARK:- Settings View
enum ButtonType {
    case music
    case info
    case credits
}

struct SettingsButton {
    weak var view: UIView!
    var buttonType: ButtonType
    var setButton: UIButton
    
    init(buttonType: ButtonType, view: UIView) {
        self.buttonType = buttonType
        self.view = view
        setButton = UIButton()
        
        setup()
    }
    
    func setup() {
        generalSetup()
        switch buttonType {
        case .music: musicBtnSetup()
        case .info: infoBtnSetup()
        case .credits: creditsBtnSetup()
        }
    }
    
    func generalSetup() {
        self.setButton.backgroundColor = UIColor.skyColor
        self.setButton.layer.borderColor = UIColor.white.cgColor
        self.setButton.layer.borderWidth = 5
        self.setButton.layer.cornerRadius = 20
        self.setButton.titleLabel?.font = UIFont(name: "Gill Sans", size: view.frame.height * 0.08)
        self.setButton.titleLabel?.textAlignment = .center
        self.setButton.setTitleColor(UIColor.white, for: .normal)
        self.setupShadow()
    }
    
    func musicBtnSetup() {
        self.setButton.setTitle("Fondyq muzyka", for: .normal)
    }
    
    func infoBtnSetup() {
        self.setButton.setTitle("Ata-analarg'a", for: .normal)
    }
    
    func creditsBtnSetup() {
        self.setButton.setTitle("Siltemeler", for: .normal)
    }
    
    func setupShadow() {
        self.setButton.layer.shadowOpacity = 0.5
        self.setButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.setButton.layer.shadowRadius = 5.0
    }
}


// MARK:- Orientation
struct AppUtility {
    // MARK:- Landscape Lock
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation: UIInterfaceOrientation) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}


func setupPlaylistSlider(value: Int) -> UISlider {
    let slider = UISlider()
    
    slider.minimumTrackTintColor = .blue
    slider.maximumTrackTintColor = .red
    slider.thumbTintColor = .white
    
    slider.minimumValue = 0
    slider.maximumValue = 100
    slider.setValue(Float(value), animated: false)
    
    return slider
}

extension UIView {
    func setupShadow() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 5.0
    }
}
