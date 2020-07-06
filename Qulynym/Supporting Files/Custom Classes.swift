/*
* Qulynym
* CustomClasses.swift
*
* Created by: Metah on 7/6/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit
import Alamofire

// MARK:- Connectivity
class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

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

// MARK: - ContainerView
enum ArrowDirection {
    case right
    case left
}

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
        self.layer.borderWidth = 2
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

// MARK:- Torgai
enum Layer: CGFloat {
    case background
    case obstacle
    case foreground
    case player
    case ui
    case flash
}

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Player: UInt32 = 0b1
    static let Obstacle: UInt32 = 0b10
    static let Ground: UInt32 = 0b100
}

