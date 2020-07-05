/*
* Qulynym
* Extensions.swift
*
* Created by: Metah on 3/3/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import Alamofire

// UIButton Constraints
extension UIButton {
    func configureCloseBtnFrame(_ view: UIView) {
        let topConstraint = self.topAnchor.constraint(equalTo: view.topAnchor)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            topConstraint.constant = -12
        }
        
        NSLayoutConstraint.activate([
            topConstraint,
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])
    }
    
    func configureForwardBtnFrame(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
}


// MARK:- UILabel properties
extension UILabel {
    func setupMenuLabel(size: CGFloat) {
        self.textColor = .white
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        setupContentLabel(size: size)
    }
    
    func setupPlaylistLabel(size: CGFloat) {
        self.shadowColor = .black
        self.textColor = UIColor(red: 97/255, green: 104/255, blue: 189/255, alpha: 1)
        self.backgroundColor = .white
        setupContentLabel(size: size)
    }
    
    private func setupContentLabel(size: CGFloat) {
        self.textAlignment = .center
        self.font = UIFont(name: "Arial Rounded MT Bold", size: size)
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

extension UIColor {
    static let skyBlue = UIColor(red: 141/255, green: 232/255, blue: 237/255, alpha: 1)
    static let beigePink = UIColor(red: 0.99, green: 0.9, blue: 0.9, alpha: 1)
}

<<<<<<< HEAD
=======
// MARK:- Settings View
enum ButtonType {
    case music
    case info
    case credits
    case tryAgain
}

class CustomButton {
    weak var view: UIView!
    var buttonType: ButtonType
    var setButton: UIButton
    
    init(buttonType: ButtonType, view: UIView) {
        self.buttonType = buttonType
        self.view = view
        setButton = UIButton(type: .system)
        
        setup()
    }
    
    func setup() {
        generalSetup()
        switch buttonType {
        case .music: musicBtnSetup()
        case .info: infoBtnSetup()
        case .credits: creditsBtnSetup()
        case .tryAgain: tryAgainBtnSetup()
        }
    }
    
    func generalSetup() {
        self.setButton.backgroundColor = UIColor.skyBlue
        self.setButton.layer.borderColor = UIColor.white.cgColor
        self.setButton.layer.borderWidth = 5
        self.setButton.layer.cornerRadius = 20
        self.setButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: view.frame.height * 0.08)
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
    
    func tryAgainBtnSetup() {
        self.setButton.setTitle("Try Again", for: .normal)
        self.setButton.sizeToFit()
    }
    
    func setupShadow() {
        self.setButton.layer.shadowOpacity = 0.5
        self.setButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.setButton.layer.shadowRadius = 5.0
    }
}

// MARK: - ArrowView
class ArrowView: UIView {
    // MARK: - Properties
    lazy var arrowImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "arrow"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    func setupLayout() {
        generalLayoutSetup()
        constraintSubviewToFitSuperview(subview: arrowImageView, superview: self)
    }
    
    func generalLayoutSetup() {
        self.isHidden = true
        self.backgroundColor = .skyBlue
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 5
        self.addSubview(arrowImageView)
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

func setupPlaylistSlider(value: Int, secondColor: UIColor) -> UISlider {
    let slider = UISlider()
    
    slider.minimumTrackTintColor = .blue
    slider.maximumTrackTintColor = secondColor
    slider.thumbTintColor = .white
    
    slider.minimumValue = 0
    slider.maximumValue = 1
    slider.setValue(Float(value), animated: false)
    
    return slider
}

>>>>>>> 60e94895c83ee4eaded25295de16a60e1c089696
extension UIView {
    func setupShadow() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 5.0
    }
}

