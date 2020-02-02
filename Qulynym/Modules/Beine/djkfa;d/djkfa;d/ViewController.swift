//
/*
* Qulynym
* ConnectionWarningViewController.swift
*
* Created by: Баубек on 2/2/20
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

class ConnectionWarningViewController: UIViewController {
    //MARK: - Properties
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.setupShadow()
        return btn
    }()
    
    private lazy var warningImageView = UIImageView(image: UIImage(named: "no connection"))
    
    private lazy var tryAgainBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: view.frame.height * 0.04)
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Try Again", for: .normal)
        btn.sizeToFit()
        return btn
    }()
 
    private lazy var warningLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Oh no! Internet connection lost!"
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: view.frame.height * 0.068)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var warningDescriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Alakay! You're not connected! Try again or ata-anany shaqyr!"
        lbl.font = UIFont(name: "Arial", size: view.frame.height * 0.032)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        addSubviewsToTheViews()
        makeMaskFalse()
        activateConstraints()
        closeBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        closeBtn.configureCloseBtnFrame(view)
    }
    
    func addSubviewsToTheViews() {
        view.addSubview(closeBtn)
        view.addSubview(warningImageView)
        view.addSubview(warningLbl)
        view.addSubview(warningDescriptionLbl)
        view.addSubview(tryAgainBtn)
    }
    
    func makeMaskFalse() {
        for view in view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            warningLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            warningLbl.widthAnchor.constraint(equalTo: view.widthAnchor),
            warningLbl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            warningDescriptionLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningDescriptionLbl.topAnchor.constraint(equalTo: warningLbl.bottomAnchor, constant: 5),
            warningDescriptionLbl.widthAnchor.constraint(equalTo: view.widthAnchor),
            warningDescriptionLbl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.04),
            
            tryAgainBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tryAgainBtn.topAnchor.constraint(equalTo: warningDescriptionLbl.bottomAnchor, constant: 40),
            tryAgainBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            tryAgainBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.14),
            
            warningImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningImageView.bottomAnchor.constraint(equalTo: warningLbl.topAnchor, constant: -20),
            warningImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.36),
            warningImageView.widthAnchor.constraint(equalTo: warningImageView.heightAnchor)
        ])
    }
    
    //MARK: - Actions
    @objc
    private func closeView() {
        self.navigationController!.popViewController(animated: true)
    }
}

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
}

extension UIView {
    func setupShadow() {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 5.0
    }
}

