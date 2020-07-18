/*
 * Qulynym
 * SettingsView.swift
 *
 * Created by: Baubek on 8/5/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
 */

import UIKit

protocol SettingsViewProtocol: class {
    var closeBtn: UIButton { get }
    var checkmarkBtn: UIButton { get }
    var musicBtn: UIButton { get }
    var infoBtn: UIButton { get }
    var creditsBtn: UIButton { get }
    var buttonHeightMultiplier: CGFloat? { get set }
    
    func setupLayout()
    func setBoxChecked()
    func setBoxUnchecked()
}

class SettingsView: SettingsViewProtocol {
    // MARK:- Properties
    var buttonHeightMultiplier: CGFloat?
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    
    lazy var checkmarkBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        return button
    }()
    
    lazy var musicBtn: UIButton = {
        let button = CustomButton(buttonType: .music, view: view)
        return button.setButton
    }()
    
    lazy var infoBtn: UIButton = {
        let button = CustomButton(buttonType: .info, view: view)
        return button.setButton
    }()
    
    lazy var creditsBtn: UIButton = {
        let button = CustomButton(buttonType: .credits, view: view)
        return button.setButton
    }()
    
    private lazy var backgroundIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "settingsBg"))
        iv.layer.zPosition = -1
        return iv
    }()

    private weak var view: UIView!
    
    // MARK:- Initialization
    required init(_ view: UIView) {
        self.view = view
    }
    
    
    // MARK:- Layout
    func setupLayout() {
        addSubviews()
        setSubviewsMask()
        closeBtn.configureCloseBtnFrame(view)
        setupButtonHeightMultiplier(horizontalSizeClass: view.traitCollection.horizontalSizeClass)
        activateConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundIV)
        view.addSubview(musicBtn)
        view.addSubview(infoBtn)
        view.addSubview(creditsBtn)
        view.addSubview(closeBtn)
        musicBtn.addSubview(checkmarkBtn)
    }
    
    private func setSubviewsMask() {
        for subview in view.subviews + musicBtn.subviews{
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            backgroundIV.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundIV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundIV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundIV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            musicBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicBtn.centerYAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.25),
            musicBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: buttonHeightMultiplier!),
            musicBtn.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            
            checkmarkBtn.trailingAnchor.constraint(equalTo: musicBtn.trailingAnchor, constant: -12),
            checkmarkBtn.topAnchor.constraint(equalTo: musicBtn.topAnchor, constant: 12),
            checkmarkBtn.bottomAnchor.constraint(equalTo: musicBtn.bottomAnchor, constant: -12),
            checkmarkBtn.widthAnchor.constraint(equalTo: checkmarkBtn.heightAnchor),
            
            infoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoBtn.heightAnchor.constraint(equalTo: musicBtn.heightAnchor),
            infoBtn.widthAnchor.constraint(equalTo: musicBtn.widthAnchor),
            
            creditsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            creditsBtn.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height * 0.25),
            creditsBtn.heightAnchor.constraint(equalTo: musicBtn.heightAnchor),
            creditsBtn.widthAnchor.constraint(equalTo: musicBtn.widthAnchor)
        ])
    }
    private func setupButtonHeightMultiplier(horizontalSizeClass: UIUserInterfaceSizeClass) {
        if horizontalSizeClass == .compact {
            buttonHeightMultiplier = 0.14
        } else {
            buttonHeightMultiplier = 0.1
        }
    }
}

extension SettingsView {
    // MARK:- Protocol Methods
    func setBoxChecked() {
        checkmarkBtn.setImage(UIImage(named: "checkbox"), for: .normal)
    }
    
    func setBoxUnchecked() {
        checkmarkBtn.setImage(nil, for: .normal)
    }
}
