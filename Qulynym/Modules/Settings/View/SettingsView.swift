/*
 * Kulynym
 * SettingsView.swift
 *
 * Created by: Баубек on 8/5/19
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
    
    func setupLayout()
    func setBoxChecked()
    func setBoxUnchecked()
}

class SettingsView: SettingsViewProtocol {
    // MARK:- Properties
    lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        return btn
    }()
    
    lazy var checkmarkBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "checkbox"), for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    lazy var musicBtn: UIButton = {
        let button = SettingsButton(buttonType: .music, view: view)
        return button.setButton
    }()
    
    lazy var infoBtn: UIButton = {
        let button = SettingsButton(buttonType: .info, view: view)
        return button.setButton
    }()
    
    lazy var creditsBtn: UIButton = {
        let button = SettingsButton(buttonType: .credits, view: view)
        return button.setButton
    }()
    
    private lazy var background: UIImageView = {
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
        activateConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(background)
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
        let constant = view.frame.height * 0.14
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            musicBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            musicBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
            musicBtn.heightAnchor.constraint(equalToConstant: constant),
            musicBtn.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            
            checkmarkBtn.trailingAnchor.constraint(equalTo: musicBtn.trailingAnchor, constant: -12),
            checkmarkBtn.topAnchor.constraint(equalTo: musicBtn.topAnchor, constant: 12),
            checkmarkBtn.bottomAnchor.constraint(equalTo: musicBtn.bottomAnchor, constant: -12),
            checkmarkBtn.widthAnchor.constraint(equalTo: checkmarkBtn.heightAnchor),
            
            infoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoBtn.topAnchor.constraint(equalTo: musicBtn.bottomAnchor, constant: constant),
            infoBtn.heightAnchor.constraint(equalTo: musicBtn.heightAnchor),
            infoBtn.widthAnchor.constraint(equalTo: musicBtn.widthAnchor),
            
            creditsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            creditsBtn.topAnchor.constraint(equalTo: infoBtn.bottomAnchor, constant: constant),
            creditsBtn.heightAnchor.constraint(equalTo: musicBtn.heightAnchor),
            creditsBtn.widthAnchor.constraint(equalTo: musicBtn.widthAnchor),
        ])
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
